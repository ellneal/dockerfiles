#!/bin/bash
set -eo pipefail

SCRIPT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$(basename "${BASH_SOURCE[0]}")"
BUILD_PREFIX="${BUILD_PREFIX:-ellneal}"

function buildandpushimage() {
    local f=${1#./}
    local image=${f%Dockerfile}
    local base=${image%%\/*}
    local build_dir=$(dirname $f)
    local tag=${build_dir##*\/}

    if [[ -z "$tag" ]] || [[ "$tag" == "$base" ]]; then
        tag=latest
    fi

    buildimage "$@" || return 1

    # on successful build, push the image
    echo "                       ---                                 "
    echo "Successfully built ${base}:${tag} with context ${build_dir}"
    echo "                       ---                                 "

    # try push a few times because notary server sometimes returns 401 for
    # absolutely no reason
    n=0
    until [ $n -ge 5 ]; do
        docker push "$BUILD_PREFIX/$base:$tag" && break
        echo "Try #$n failed... sleeping for 15 seconds"
        n=$[$n+1]
        sleep 15
    done
}

function buildimage() {
    local f=${1#./}
    local image=${f%Dockerfile}
    local base=${image%%\/*}
    local build_dir=$(dirname $f)
    local tag=${build_dir##*\/}

    if [[ -z "$tag" ]] || [[ "$tag" == "$base" ]]; then
        tag=latest
    fi
    
    echo "Building $BUILD_PREFIX/$base:$tag in $build_dir"

    docker build --rm --force-rm -t "$BUILD_PREFIX/$base:$tag" $build_dir || return 1
}

function removeimage() {
    local f=${1#./}
    local image=${f%Dockerfile}
    local base=${image%%\/*}
    local build_dir=$(dirname $f)
    local tag=${build_dir##*\/}

    if [[ -z "$tag" ]] || [[ "$tag" == "$base" ]]; then
        tag=latest
    fi
    
    echo "Removing $BUILD_PREFIX/$base:$tag"

    docker rmi "$BUILD_PREFIX/$base:$tag" || echo
}

function buildall() {
    find . -iname '*Dockerfile' -print0 | sort -z | xargs -0 -I file $SCRIPT buildandpushimage file
}

function removeall() {
    find . -iname '*Dockerfile' -print0 | sort -z | xargs -0 -I file $SCRIPT removeimage file
}

function main() {
    f=$1

    if [[ "$f" == "" ]]; then
        echo "Pass 'all' to build all images" && exit 1
    elif [[ "$f" == "all" ]]; then
        buildall
    elif [[ "$f" == "clean" ]]; then
        removeall
    elif [[ -f "$f" ]]; then
        buildimage "$@"
    elif [[ -d "$f" ]]; then
        shift
        buildimage "$(basename "$f")/Dockerfile" "$@"
    else
        $@
    fi
}

main "$@"
