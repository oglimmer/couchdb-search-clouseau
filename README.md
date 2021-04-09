# Docker image for couchdb's search plugin using clouseau

This repo builds the docker image for https://github.com/cloudant-labs/clouseau

It is supposed to be a replacement for https://hub.docker.com/r/kocolosk/couchdb-search as this does NOT support ARM.

## Start parameters for java

clouseau should be started with `-Xmx2G`, but this image uses `-Xmx1G`. If you want to change that, use `JAVA_XMX=-Xmx2G` as an environment variable.

## couchdb-helm

The helm-chart https://github.com/apache/couchdb-helm/tree/main/couchdb is using kocolosk/couchdb-search by default, so if you're on ARM you might want to use:

```
    --set enableSearch=true \
    --set searchImage.repository=couchdb-search-clouseau \
    --set searchImage.tag=latest \
    --set searchImage.pullPolicy=Always
```

## multi platform build

This is taken from https://www.docker.com/blog/multi-arch-build-and-images-the-simple-way/.

```
docker buildx build --push --platform linux/arm64,linux/amd64 --tag oglimmer/couchdb-search-clouseau:latest .
```