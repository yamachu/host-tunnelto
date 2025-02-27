FROM clux/muslrust:stable as build

RUN --mount=type=bind,target=.,readwrite,source=./tunnelto cargo build --bin tunnelto_server --release \
    && cp ./target/aarch64-unknown-linux-musl/release/tunnelto_server /bin/tunnelto_server

FROM alpine:latest

COPY --from=build /bin/tunnelto_server /tunnelto_server

# client svc
EXPOSE 8080
# ctrl svc
EXPOSE 5000
# net svc
EXPOSE 10002

ENTRYPOINT ["/tunnelto_server"]
