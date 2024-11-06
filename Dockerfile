# This is a standard Dockerfile for building a Go app.
# It is a multi-stage build: the first stage compiles the Go source into a binary, and
#   the second stage copies only the binary into an alpine base.

# -- Stage 1 -- #
# Compile the app.
#FROM golang:1.12-alpine as builder
FROM golang:1.19
WORKDIR /app
# The build context is set to the directory where the repo is cloned.
# This will copy all files in the repo to /app inside the container.
# If your app requires the build context to be set to a subdirectory inside the repo, you
#   can use the source_dir app spec option, see: https://www.digitalocean.com/docs/app-platform/references/app-specification-reference/
COPY . .
#RUN go build -o ./userapi
# Build
RUN CGO_ENABLED=0 GOOS=linux go build -o /docker-gs-ping
# -- Stage 2 -- #
# Create the final environment with the compiled binary.
#FROM gcr.io/distroless/base-debian12
# Install any required dependencies.
#RUN apk --no-cache add ca-certificates
#WORKDIR /app
# Copy the binary from the builder stage and set it as the default command.
#COPY --from=builder /app/userapi ./userapi
CMD ["/docker-gs-ping"]