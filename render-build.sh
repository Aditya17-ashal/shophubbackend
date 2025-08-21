#!/bin/bash

# Render build script for ShopHub Backend
echo "Starting Render build process..."

# Make mvnw executable
chmod +x ./mvnw

# Clean and package the application, skipping tests for faster deployment
echo "Building application with Maven..."
./mvnw clean package -DskipTests

echo "Build completed successfully!"
