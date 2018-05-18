FROM swift:latest

RUN git clone https://github.com/realm/SwiftLint.git && \
    cd SwiftLint && \
    git checkout $(curl -s https://api.github.com/repos/realm/SwiftLint/releases/latest | grep tag_name | cut -d '"' -f 4) && \
    git submodule update --init --recursive && \
    make install && \
    cd .. && \
    rm -rf SwiftLint

ENTRYPOINT ["/usr/local/bin/swiftlint"]
