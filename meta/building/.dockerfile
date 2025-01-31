# Build stage
FROM sub_new:latest AS builder

WORKDIR /app

# Copy files from Github
COPY ./meta/building/renv.lock ./project ./

RUN mkdir output

#Quarto render all our documents
RUN quarto render --output-dir output

#Final Stage
FROM scratch
COPY --from=builder /app/output /
