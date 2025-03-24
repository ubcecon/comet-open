# syntax=docker/dockerfile:1.4
FROM --platform=$BUILDPLATFORM alexr951/testing_comet:test AS builder
#FROM --platform=$BUILDPLATFORM jlgraves/comet-test:test AS builder (Change once migrated)

WORKDIR /app

# Copy files from Github
COPY ./meta/building/renv.lock ./project ./

RUN mkdir output

# Quarto render all our documents
RUN quarto render --output-dir output

# Final stage
FROM --platform=$TARGETPLATFORM nginx:alpine  
COPY --from=builder --chown=nginx:nginx /app/output /usr/share/nginx/html  
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
