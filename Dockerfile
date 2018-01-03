FROM golang:onbuild AS build-env

ADD . /src
WORKDIR /src
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app .

FROM alpine:latest
RUN apk --no-cache add ca-certificates
COPY --from=build-env /src/app /srv/
EXPOSE 8080
WORKDIR /srv/
CMD ["./app"]
