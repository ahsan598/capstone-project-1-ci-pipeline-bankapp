# ----------- Stage 1: Build Stage -----------

# Import docker image with maven installed
FROM maven:3.9.6-eclipse-temurin-21 AS builder 

# Add labels to the image to filter out if we have multiple application running
LABEL app=bankapp

# Set working directory
WORKDIR /src

# Copy source code from local to container
COPY . .

# Build application and skip test cases
RUN mvn clean install -DskipTests=true



# ----------- Stage 2: Runtime Stage -----------

# Import small size java image
FROM eclipse-temurin:21-jre AS deployer

WORKDIR /app

# Copy JAR from builder stage
COPY --from=builder /src/target/*.jar /app/bankapp.jar

# Expose application port 
EXPOSE 8080

# Start the application
ENTRYPOINT ["java", "-jar", "/src/target/bankapp.jar"]
