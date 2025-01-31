# Build stage
FROM sub_new:latest AS builder

WORKDIR /app

# Copy files from Github
COPY ./meta/building/renv.lock ./project ./

RUN mkdir output

#Quarto render all our documents
RUN quarto render --output-dir output

# Final stage (Alpine linux as a base for Nektos Act)
FROM alpine:latest

# Install basic utilities (bash again for Nektos Act)
RUN apk add --no-cache coreutils bash

COPY --from=builder /app/output /app/output

# Set the working directory (This time in the Final Stage)
WORKDIR /app

