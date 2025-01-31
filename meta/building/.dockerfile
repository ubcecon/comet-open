# Build stage
FROM sub_new:latest AS builder

WORKDIR /app

# Copy files from Github
COPY ./meta/building/renv.lock ./project ./

RUN mkdir output

#Quarto render all our documents
RUN quarto render --output-dir output

#Final stage
# Alpine linux basic utility so (Nektos Act will work)
FROM alpine:latest

# Install basic utilities (including coreutils)
RUN apk add --no-cache coreutils

COPY --from=builder /app/output /app/output

# Set the working directory (This time in the Final Stage)
WORKDIR /app

