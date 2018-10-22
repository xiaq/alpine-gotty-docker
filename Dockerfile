FROM golang:alpine as builder
RUN apk update && \
    apk add --virtual build-deps make git
# Build gotty
RUN go get -d github.com/yudai/gotty && \
    git -C /go/src/github.com/yudai/gotty checkout release-1.0 && \
    go get github.com/yudai/gotty

FROM alpine
COPY gotty.conf /root/.gotty
COPY --from=builder /go/bin/gotty /bin/gotty
RUN apk update && apk add docker
EXPOSE 80
CMD ["/bin/gotty"]
