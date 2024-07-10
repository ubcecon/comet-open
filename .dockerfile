FROM rocker/tidyverse:latest as builder

WORKDIR /app

RUN install2.r --error \
    renv \
    stargazer

COPY renv.lock /app/renv.lock
COPY comet-quarto /app

RUN apt-get update --fix-missing && \
    apt-get install -y \
    curl \
    gdebi-core \
    libgl1-mesa-glx \
    libxt6 \
    python3.10 \
    python3-pip && \
    python3 -m pip install jupyter && \
    curl -LO https://quarto.org/download/latest/quarto-linux-amd64.deb && \
    gdebi -n quarto-linux-amd64.deb && \
    rm quarto-linux-amd64.deb && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN Rscript -e 'install.packages(c("xfun", "vctrs", "rmarkdown", "tidyverse", "knitr", "IRkernel"))'

RUN mkdir output
RUN quarto check
RUN quarto render --output-dir output

FROM scratch

COPY --from=builder /app/output /artifacts/build
