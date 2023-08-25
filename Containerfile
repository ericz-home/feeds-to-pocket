FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y \
	ca-certificates \
	openssl \
	&& rm -rf /var/lib/apt/lists/* 

COPY target/release/feeds-to-pocket /

ENTRYPOINT ["/feeds-to-pocket"]
