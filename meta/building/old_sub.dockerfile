# This file will act as the build stage (stage 1)
#This file will show the package numbers so I can update the main

FROM rocker/tidyverse:4.2.2 AS builder

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    gdebi-core \
    libgl1 \
    libglx-mesa0 \
    libxt6 \
    python3-pip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Print system package versions
RUN echo "System package versions:" && \
    dpkg-query -W -f='${Package}: ${Version}\n' curl gdebi-core libgl1 libglx-mesa0 libxt6 python3-pip

# Install Python packages
RUN python3 -m pip install jupyter==1.0.0

# Print Python package versions
RUN echo "Python package versions:" && \
    pip list

# Install Quarto
RUN curl -LO https://github.com/quarto-dev/quarto-cli/releases/download/v1.3.450/quarto-1.3.450-linux-amd64.deb \
    && gdebi -n quarto-1.3.450-linux-amd64.deb \
    && rm quarto-1.3.450-linux-amd64.deb

# Print Quarto version
RUN echo "Quarto version:" && \
    quarto --version

# Install R packages
RUN install2.r --error renv stargazer \
    && Rscript -e 'install.packages(c("xfun", "vctrs", "rmarkdown", "tidyverse", "knitr", "IRkernel"), repos="https://cran.rstudio.com/")'

# Print R package versions
RUN echo "R package versions:" && \
    Rscript -e 'installed.packages()[c("renv", "stargazer", "xfun", "vctrs", "rmarkdown", "tidyverse", "knitr", "IRkernel"), "Version"]'

# Verify Quarto installation
RUN quarto check
