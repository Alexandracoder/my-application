FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    openjdk-11-jdk \
    maven \
    curl \
    git \
    && apt-get clean

WORKDIR /app

COPY . /app

RUN mvn clean install

CMD ["java", "-jar", "target/app.jar"]