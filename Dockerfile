FROM adoptopenjdk:8-jre-hotspot-bionic 

ARG CLOUSEAU_VERSION=2.17.0
ARG DIST_URL=https://github.com/cloudant-labs/clouseau/releases/download/${CLOUSEAU_VERSION}/clouseau-${CLOUSEAU_VERSION}-dist.zip

RUN apt update && apt -y install wget unzip && rm -rf /var/lib/apt/lists/*

COPY etc /opt/clouseau/etc/
COPY bin /opt/clouseau/bin/

RUN mkdir -p /opt/clouseau/lib/ && cd /opt/clouseau/lib/ && wget ${DIST_URL} && \
    unzip clouseau-${CLOUSEAU_VERSION}-dist.zip && \
    rm clouseau-${CLOUSEAU_VERSION}-dist.zip && \
    mv clouseau-${CLOUSEAU_VERSION}/* . && \
    rmdir clouseau-${CLOUSEAU_VERSION}

RUN mkdir -p /opt/clouseau/data && chown -R 5984:5984 /opt/clouseau

USER 5984
EXPOSE 9090

VOLUME /opt/clouseau/data 

WORKDIR /opt/clouseau/

ENTRYPOINT ["./bin/start.sh"]
CMD ["start"]
