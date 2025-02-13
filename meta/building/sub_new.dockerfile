# This file will act as the build stage (stage 1)
FROM rocker/tidyverse:4.2.2 AS builder

WORKDIR /app

# Install system dependencies
    # For now no version numbers to try to get it to work
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl=8.12.1 \
    gdebi-core=0.9.5.8 \
    libgl1=1.4.0-1 \
    libglx-mesa0=23.2.1-1ubuntu3.1~22.04.2 \
    libxt6=1:1.2.1-1 \
    python3-pip=25.0.1 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install Python packages
RUN python3 -m pip install jupyter==1.0.0

# Install Quarto
RUN curl -LO https://github.com/quarto-dev/quarto-cli/releases/download/v1.3.450/quarto-1.3.450-linux-amd64.deb \
    && gdebi -n quarto-1.3.450-linux-amd64.deb \
    && rm quarto-1.3.450-linux-amd64.deb

# Install R packages (So far no version stuff to see if it works)
RUN install2.r --error renv@1.1.1 stargazer@5.2.3 \
    && Rscript -e 'install.packages(c("xfun"@0.50, "vctrs@0.6.5", "rmarkdown@2.29", "tidyverse@2.0.0", "knitr@1.49", "IRkernel@1.3.2"), repos="https://cran.rstudio.com/")'


# Verify Quarto installation
RUN quarto check
