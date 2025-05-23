# Build stage
FROM maven:3.8-openjdk-8 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Run stage
FROM eclipse-temurin:8-jre-alpine
WORKDIR /app

# Create a non-root user
RUN addgroup -S spring && adduser -S spring -G spring
USER spring:spring

# Copy the jar from build stage
COPY --from=build /app/target/*.jar app.jar

# Add security configurations
ENV JAVA_OPTS="-Xms512m -Xmx512m -Djava.security.egd=file:/dev/./urandom"

# Expose the application port
EXPOSE 8080

# Run the application
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar app.jar"]