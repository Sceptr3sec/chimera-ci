FROM ubuntu:22.04

# Install basics
RUN apt-get update && apt-get install -y \
    python3 python3-pip curl git unzip wget \
    openjdk-17-jdk \
    && rm -rf /var/lib/apt/lists/*

# Install Semgrep
RUN pip install semgrep

# Install Trivy
RUN curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sh

# Install Checkov
RUN pip install checkov

# Install Gitleaks
RUN wget https://github.com/gitleaks/gitleaks/releases/download/v8.18.0/gitleaks_8.18.0_linux_x64.tar.gz \
    && tar -xvzf gitleaks_8.18.0_linux_x64.tar.gz \
    && mv gitleaks /usr/local/bin/

# ZAP baseline scan
RUN wget https://github.com/zaproxy/zaproxy/releases/download/v2.16.1/ZAP_2.16.1_Linux.tar.gz \
    && tar -xvzf ZAP_2.16.1_Linux.tar.gz -C /opt/ \
    && ln -s /opt/ZAP_2.16.1/zap.sh /usr/local/bin/zap.sh \
    && rm ZAP_2.16.1_Linux.tar.gz




WORKDIR /app
ENTRYPOINT ["/bin/bash"]

