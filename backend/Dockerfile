FROM golang:1.19-alpine as builder
WORKDIR /usr/app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -o ./run/momo-store ./cmd/api
FROM alpine:latest AS build-release
WORKDIR /app
COPY --from=builder /usr/app/run/momo-store ./momo-store
EXPOSE 8081
ENTRYPOINT [ "./momo-store"]