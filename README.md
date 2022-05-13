# docker-ubuntu-sshd

### docker build
```
docker build --build-arg SSH_USER=ubuntu --build-arg SSH_PASSWORD=ubuntu -t anti1346/ubuntu-sshd:22.04 .
```

### docker-compose build

```
(or) 
docker-compose build --no-cache

docker-compose up -d; docker-compose ps; docker-compose logs -f
```
```
docker-compose up --build -d; docker-compose ps; docker-compose logs -f

docker-compose exec ssh-server bash
```

###### docker container ip
```
docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' ssh-server
```

#### ssh access info
ubuntu / ubuntu
