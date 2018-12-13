FROM swift:latest

RUN apt-get update && apt-get install -y \
        apt-transport-https \
        wget && \
    wget -q https://repo.vapor.codes/apt/keyring.gpg -O- | apt-key add - && \
    echo "deb https://repo.vapor.codes/apt xenial main" > /etc/apt/sources.list.d/vapor.list && \
    apt-get update && apt-get install -y \
        vapor && \
    rm -rf /var/lib/apt/lists/*
