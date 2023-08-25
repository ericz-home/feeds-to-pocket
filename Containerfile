FROM rust:slim-bookworm as builder

RUN apt-get update && apt-get install -y \
    libssl-dev \
	openssl \
    pkg-config \
	&& rm -rf /var/lib/apt/lists/* 

WORKDIR /rust
COPY src src
COPY Cargo.* .

RUN cargo build --release

FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y \
	ca-certificates \
	openssl \
	&& rm -rf /var/lib/apt/lists/* 

COPY --from=builder /rust/target/release/feeds-to-pocket /

ENTRYPOINT ["/feeds-to-pocket"]
