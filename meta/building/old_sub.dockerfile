# This file will act as the build stage (stage 1)
FROM rocker/tidyverse:4.2.2 AS builder

WORKDIR /app

# Install system dependencies
    # For now no version numbers to try to get it to work
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

# Install Quarto
RUN curl -LO https://github.com/quarto-dev/quarto-cli/releases/download/v1.3.450/quarto-1.3.450-linux-amd64.deb \
    && gdebi -n quarto-1.3.450-linux-amd64.deb \
    && rm quarto-1.3.450-linux-amd64.deb

# Install R packages (So far no version stuff to see if it works)
RUN install2.r --error renv stargazer \
    && Rscript -e 'install.packages(c("xfun", "vctrs", "rmarkdown", "tidyverse", "knitr", "IRkernel"), repos="https://cran.rstudio.com/")'


# Verify Quarto installation
RUN quarto check