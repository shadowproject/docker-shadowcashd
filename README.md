# ludx/shadowcashd
A shadowcashd docker image, the fastest method of getting fully synchronised client online within minutes.
Automatically downloads and uses the latest blockchain from [shadowproject/blockchain](https://github.com/shadowproject/blockchain).

## Usage

```sh
$ docker run -d --restart=always \
    -p 51736:51736 -p 51737:51737 \
    -v /hostdatafolder:/home/shadowcash/.shadowcoin \
    --name shadowcashd ludx/shadowcashd
```

## License
[License information](https://github.com/shadowproject/shadow/blob/master/COPYING) for the software contained in this image.

[License information](https://github.com/shadowproject/docker-shadowcashd/blob/master/LICENSE) for the [ludx/shadowcashd](https://hub.docker.com/r/ludx/shadowcashd) docker project.
