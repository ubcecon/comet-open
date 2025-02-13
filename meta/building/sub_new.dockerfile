# This file will act as the build stage (stage 1)
FROM rocker/tidyverse:4.2.2 AS builder

WORKDIR /app

# Install system dependencies 
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl=7.74.0-* \
    gdebi-core=0.9.5* \
    libgl1=1.3* \
    libglx-mesa0=20.3* \
    libxt6=1:1.2* \
    python3-pip=20.3* \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install Python packages
RUN python3 -m pip install jupyter==1.0.0

# Install Quarto
RUN curl -LO https://github.com/quarto-dev/quarto-cli/releases/download/v1.3.450/quarto-1.3.450-linux-amd64.deb \
    && gdebi -n quarto-1.3.450-linux-amd64.deb \
    && rm quarto-1.3.450-linux-amd64.deb

# Install R packages
RUN install2.r --error renv@0.17.3 stargazer@5.2.3 \
    && Rscript -e 'install.packages(c("xfun@0.39", "vctrs@0.6.2", "rmarkdown@2.21", "tidyverse@2.0.0", "knitr@1.42", "IRkernel@1.3.2"), repos="https://cran.rstudio.com/")'

# Verify Quarto installation
RUN quarto check
