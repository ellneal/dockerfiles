FROM buildpack-deps:stretch

ENV VERSION=1.0.0
RUN wget -O githubcli.tar.gz https://github.com/cli/cli/releases/download/v${VERSION}/gh_${VERSION}_linux_386.tar.gz ; \
    tar -xf githubcli.tar.gz && \
    rm githubcli.tar.gz && \
    ln -s /gh_${VERSION}_linux_386/bin/gh /bin/gh

ENTRYPOINT ["/bin/gh"]
