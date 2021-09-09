# Use the official bison-flex image
# https://hub.docker.com/r/knordman/bison-flex-builder
FROM knordman/bison-flex-builder:latest


# Install GCC
RUN apt-get install gcc

# Copy local code to the container image.
ENV APP_HOME /app
WORKDIR $APP_HOME
COPY . ./

RUN bison -d java_grammar.y
RUN flex java_identifiers.l
RUN gcc -o run java_grammar.tab.c lex.yy.c