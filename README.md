# tools-curl
Alpine-based image with just curl wget vim

## Usage

```console
$ docker run --rm registry.cn-shanghai.aliyuncs.com/allthink/curl -fsSL https://www.google.com/
$ docker run --rm registry.cn-shanghai.aliyuncs.com/allthink/curl wget https://www.google.com/
$ docker run --rm registry.cn-shanghai.aliyuncs.com/allthink/curl ssh 10.1.0.1
```

## Tags

* `registry.cn-shanghai.aliyuncs.com/allthink/curl:latest`: based on `alpine:latest`

## License

Copyright © 2020 Appropriate Computing

All contents licensed under the [MIT License](LICENSE)
