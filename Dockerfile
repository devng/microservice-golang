FROM golang:latest AS build-env
RUN go get -u github.com/golang/dep/cmd/dep

WORKDIR /go/src/project/
COPY . /go/src/project/
RUN dep ensure
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app .

# ---

FROM alpine:latest
RUN apk --no-cache add ca-certificates

COPY --from=build-env /go/src/project/app /srv/app

EXPOSE 8080
ENTRYPOINT /srv/app
