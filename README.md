# docker-ubuntu-sshd

### docker build
```
docker build --build-arg SSH_USER=ubuntu --build-arg SSH_PASSWORD=ubuntu -t anti1346/ubuntu-sshd:22.04 .
```

### docker-compose build

```
(or) docker-compose build --no-cache

docker-compose up --build -d; docker-compose logs -f

docker-compose exec ssh-server bash
```

### ssh access info
ubuntu / ubuntu
