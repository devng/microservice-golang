FROM golang:onbuild AS builder

ADD . .
RUN go build -o /app .

FROM alpine:latest
COPY --from=builder /app /app
EXPOSE 8080
CMD ["/app"]
