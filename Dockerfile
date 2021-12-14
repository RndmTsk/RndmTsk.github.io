FROM swift:latest as builder
WORKDIR /generation
COPY ./generation .
RUN swift build -c release

FROM swift:slim
WORKDIR /code
COPY --from=builder /generation/.build/release/generation /usr/local/bin
ENTRYPOINT ["/usr/local/bin/generation"]