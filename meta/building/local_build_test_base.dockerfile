# syntax=docker/dockerfile:1.4
# This file will act as the build stage (stage 1)
# Date 2025-03-19

# Base image selection with multi-architecture support
FROM --platform=$BUILDPLATFORM rocker/r-ver:4.3.1 AS base

WORKDIR /app

# Install system dependencies with versions
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    gdebi-core \
    libgl1 \
    libglx-mesa0 \
    libxt6 \
    python3-pip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install Python packages
RUN python3 -m pip install jupyter==1.0.0

# Specific Quarto Install using build architecture detection
ARG TARGETARCH
RUN if [ "$TARGETARCH" = "amd64" ] || [ "$(uname -m)" = "x86_64" ]; then \
        QUARTO_DEB="quarto-1.3.450-linux-amd64.deb"; \
    elif [ "$TARGETARCH" = "arm64" ] || [ "$(uname -m)" = "aarch64" ]; then \
        QUARTO_DEB="quarto-1.3.450-linux-arm64.deb"; \
    else \
        echo "Unsupported architecture: $TARGETARCH $(uname -m)" && exit 1; \
    fi && \
    curl -LO "https://github.com/quarto-dev/quarto-cli/releases/download/v1.3.450/${QUARTO_DEB}" && \
    gdebi -n "${QUARTO_DEB}" && \
    rm "${QUARTO_DEB}"

# Install R packages with version numbers
RUN R -e "install.packages('remotes')" && \
    R -e "remotes::install_version('renv', version = '0.15.5', repos = 'https://cloud.r-project.org/')" && \
    R -e "remotes::install_version('stargazer', version = '5.2.3', repos = 'https://cloud.r-project.org/')" && \
    R -e "remotes::install_version('xfun', version = '0.47', repos = 'https://cloud.r-project.org/')" && \
    R -e "remotes::install_version('vctrs', version = '0.6.5', repos = 'https://cloud.r-project.org/')" && \
    R -e "remotes::install_version('rmarkdown', version = '2.29', repos = 'https://cloud.r-project.org/')" && \
    R -e "remotes::install_version('tidyverse', version = '2.0.0', repos = 'https://cloud.r-project.org/')" && \
    R -e "remotes::install_version('knitr', version = '1.49', repos = 'https://cloud.r-project.org/')" && \
    R -e "remotes::install_version('IRkernel', version = '1.3.2', repos = 'https://cloud.r-project.org/')"

# Verify Quarto installation
RUN quarto check
