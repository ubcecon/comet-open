# This file will act as the build stage (stage 1)

FROM rocker/tidyverse:4.2.2 AS builder

WORKDIR /app

# Install system dependencies with specific versions
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl=7.81.0-1ubuntu1.20 \
    gdebi-core=0.9.5.7+nmu6 \
    libgl1=1.4.0-1 \
    libglx-mesa0=23.2.1-1ubuntu3.1~22.04.3 \
    libxt6=1:1.2.1-1 \
    python3-pip=22.0.2+dfsg-1ubuntu0.5 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install Python packages
RUN python3 -m pip install jupyter==1.0.0

# Install Quarto
RUN curl -LO https://github.com/quarto-dev/quarto-cli/releases/download/v1.3.450/quarto-1.3.450-linux-amd64.deb \
    && gdebi -n quarto-1.3.450-linux-amd64.deb \
    && rm quarto-1.3.450-linux-amd64.deb

# Install R packages
RUN install2.r --error renv@1.1.0 stargazer@5.2.3 \
    && Rscript -e 'install.packages(c("xfun@0.47", "vctrs@0.6.5", "rmarkdown@2.29", "tidyverse@2.0.0", "knitr@1.49", "IRkernel@1.3.2.9000"), repos="https://cran.rstudio.com/")'

# Verify Quarto installation
RUN quarto check
