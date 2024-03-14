FROM https://artifactory.glss.ir:443/artifactory/dockerhub/alpine:latest
WORKDIR /app
COPY hello.sh .
RUN chmod +x hello.sh
CMD ["./hello.sh"]
