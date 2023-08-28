FROM rust:slim-bullseye as builder

RUN apt-get update && apt-get install -y \
    libssl-dev \
	openssl \
    pkg-config \
	&& rm -rf /var/lib/apt/lists/* 

WORKDIR /rust
COPY src src
COPY Cargo.* .

RUN cargo build --release

FROM gcr.io/distroless/cc-debian11:nonroot

COPY --from=builder /rust/target/release/feeds-to-pocket /

ENTRYPOINT ["/feeds-to-pocket"]
