# Build stage
FROM --platform=linux/amd64 jlgraves/comet-test:test AS builder

WORKDIR /app

# Copy files from Github
COPY ./meta/building/renv.lock ./project ./
# Add this line to copy media directory
#COPY ./media ./media/

RUN mkdir output

# Quarto render all our documents
RUN quarto render --output-dir output

# Final Stage (Added this so it can be ran locally and tested properly)
FROM nginx:alpine
COPY --from=builder /app/output /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
