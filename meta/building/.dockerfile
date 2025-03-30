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

# Install compatible dependencies
RUN python3 -m pip install "jupyter-cache>=0.6" "nbclient>=0.8,<1.0"

# Quarto render with optimized parameters
RUN quarto render --output-dir output \
    --execute-daemon 300 \
    --kernel python3 \
    --cache
    
# Final stage
FROM --platform=$TARGETPLATFORM nginx:alpine  
COPY --from=builder --chown=nginx:nginx /app/output /usr/share/nginx/html  
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
