# Build stage
FROM jlgraves/comet-test:test AS builder

WORKDIR /app

# Copy files from Github
COPY ./meta/building/renv.lock ./project ./

RUN mkdir output

# Remove pre-rendered notebooks before full site render
RUN rm -f ./docs/4_Advanced/advanced_word_embeddings/advanced_word_embeddings_python_version.qmd

# Quarto render all our documents
RUN quarto render --output-dir output

# Copy pre-rendered HTML into output
COPY ./project/docs/4_Advanced/advanced_word_embeddings/advanced_word_embeddings_python_version.html /app/output/docs/4_Advanced/advanced_word_embeddings/

# Final Stage (Added this so it can be ran locally and tested properly)
FROM nginx:alpine
COPY --from=builder /app/output /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
