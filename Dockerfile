FROM alpine:3.19

# Install required packages
RUN apk add --no-cache \
    curl \
    git \
    bash \
    wget

# Install helm directly
RUN wget https://get.helm.sh/helm-v3.14.2-linux-amd64.tar.gz && \
    tar -zxvf helm-v3.14.2-linux-amd64.tar.gz && \
    mv linux-amd64/helm /usr/local/bin/helm && \
    rm -rf linux-amd64 helm-v3.14.2-linux-amd64.tar.gz

# Set working directory
WORKDIR /app

# Create entrypoint script
RUN echo -e '#!/bin/bash\nif [ $# -eq 0 ]; then\n  exec /bin/bash\nelse\n  exec "$@"\nfi' > /entrypoint.sh && \
    chmod +x /entrypoint.sh

# Set the entrypoint
ENTRYPOINT ["/entrypoint.sh"]