# syntax=docker/dockerfile:1.4
# Date: 2025-03-30
FROM --platform=$BUILDPLATFORM alexr951/testing_comet:test AS builder

WORKDIR /app

# Copy files from Github
COPY ./meta/building/renv.lock ./project ./

RUN mkdir output

# Environment configuration
ENV HOMEBREW_NO_ENV_HINTS=1
ENV HOMEBREW_NO_INSTALL_CLEANUP=1
ENV QUARTO_PYTHON=/usr/bin/python3
ENV QUARTO_EXECUTE_NUM_THREADS=2  

# Install dependencies with explicit versions
RUN python3 -m pip install jupyter-cache==0.5.0 nbclient==0.10.0

# Quarto render with kernel specification and no cache
RUN quarto render --output-dir output \
    --execute-daemon 300 \
    --kernel python3 \
    --no-cache

# Final stage
FROM --platform=$TARGETPLATFORM nginx:alpine  
COPY --from=builder --chown=nginx:nginx /app/output /usr/share/nginx/html  
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
