FROM rust:1.72-bookworm AS build
WORKDIR /feeds-to-pocket
RUN ["cargo", "install", "feeds-to-pocket"]

FROM debian:bookworm-slim AS final
RUN apt-get update \
    && apt-get install -y openssl ca-certificates \
    && rm -rf /var/lib/apt/lists/*
COPY --from=build /usr/local/cargo/bin/feeds-to-pocket /usr/local/bin/
VOLUME /config
CMD ["feeds-to-pocket", "/config/config.yaml"]
