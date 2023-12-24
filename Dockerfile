FROM golang:1.22rc1-alpine AS build
COPY . /usr/project
WORKDIR /usr/project
RUN go mod init app && CGO_ENABLED=0 go build -ldflags="-s -w" -o /usr/project/app

FROM scratch
WORKDIR /usr/project
COPY --from=build /usr/project/app /usr/project/app
ENTRYPOINT [ "./app" ]
