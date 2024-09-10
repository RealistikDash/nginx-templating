# nginx-templating
An NGINX Docker image supporting templating through environment variables.

## What does it do?
This module searches through all all `*.template` files within the `/templates` directory and 
formats them at startup using all of the available environment variables.

```nginx
server {
    listen 80;
    server_name a.${SERVER_DOMAIN};

    location / {
        proxy_pass http://${SERVER_PROXY_TARGET}/example;
    }
}
```

In this example, the environment variable `SERVER_DOMAIN` is used to set the host to which this server will respond,
while the variable `SERVER_PROXY_TARGET` decides the target.


## Example usage
Templates are included in the image upon building. This means that one way to feed new templates is to just include them inside
the `templates` folder and building the image.

This will however require re-building the image each time a template is changed. To avoid this, you may create a read-only volume
to the `/templates` directory, as the template complation is done at image startup.

An example involving Docker Compose may look like:
```yaml
services:
  nginx:
    image: nginx-templated:latest
    restart: always
    ports:
      - 80:80
    volumes:
      - ./templates:/templates:ro
    environment:
      - SERVER_DOMAIN=localhost
      - SERVER_PROXY_TARGET=1.1.1.1
```
