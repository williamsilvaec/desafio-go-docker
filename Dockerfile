FROM golang:latest AS builder
WORKDIR /app
COPY go.mod ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main .


FROM scratch
WORKDIR /app
COPY --from=builder /app/main .
CMD ["./main"]

