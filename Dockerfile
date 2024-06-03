FROM golang:1.22-alpine as build
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 go build -ldflags '-extldflags "-static"' -o build/fizzbuzz

FROM gcr.io/distroless/static-debian12
COPY --from=build /app/build/fizzbuzz  /build/fizzbuzz
EXPOSE 8080
CMD ["./build/fizzbuzz","serve"]