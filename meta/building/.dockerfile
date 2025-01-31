# Build stage
FROM sub_new:latest AS builder

#Debian Linux Coreutils (for Nektos to work)
RUN apt-get update && apt-get install -y coreutils

WORKDIR /app

# Copy necessary files
COPY ./meta/building/renv.lock ./project ./

# Create output directory
RUN mkdir output

# Render Quarto document
RUN quarto render --output-dir output

# Final stage
FROM scratch
COPY --from=builder /app/output /

