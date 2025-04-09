FROM eclipse-temurin:21

WORKDIR /app

RUN wget -q -O /app/tla2tools.jar https://github.com/tlaplus/tlaplus/releases/download/v1.7.4/tla2tools.jar && \
    ls -la /app/tla2tools.jar

ENTRYPOINT ["java", "-cp", "/app/tla2tools.jar"]
CMD ["tlc2.TLC"]
