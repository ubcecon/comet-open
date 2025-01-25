# Build stage
FROM sub_new:latest as builder

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

