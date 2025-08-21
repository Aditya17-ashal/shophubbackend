# ShopHub Backend Deployment Guide

This guide explains how to deploy the ShopHub Backend to various platforms.

## 🚀 Render Deployment (Recommended)

### Prerequisites
- GitHub repository with your code
- Render account (free tier available)

### Setup Steps

1. **Repository Structure Fixed**
   - Maven wrapper files (`mvnw`, `mvnw.cmd`, `.mvn/`) are now in the root directory
   - `pom.xml` is configured to find source code in the `shophubbackend/` subdirectory
   - Build script `render-build.sh` handles the build process

2. **Render Configuration**
   - `render.yaml` file configures the deployment
   - Build command: `./render-build.sh`
   - Start command: `java -jar target/shophubbackend-0.0.1-SNAPSHOT.jar`

3. **Deploy to Render**
   - Connect your GitHub repository to Render
   - Render will automatically detect the `render.yaml` configuration
   - Set environment variables in Render dashboard:
     ```
     MONGODB_URI=your_mongodb_connection_string
     JWT_SECRET=your_jwt_secret_key
     CORS_ALLOWED_ORIGINS=https://your-frontend-domain.com
     ```

### Environment Variables for Render
```bash
# Required
MONGODB_URI=mongodb+srv://username:password@cluster.mongodb.net/database
JWT_SECRET=your-base64-encoded-secret

# Optional
MONGODB_DATABASE=shophub
JWT_EXPIRATION=86400000
CORS_ALLOWED_ORIGINS=https://your-frontend.com
```

## 🐳 Docker Deployment

### Build and Run Locally
```bash
# Build the Docker image
docker build -t shophub-backend .

# Run the container
docker run -p 8080:8080 \
  -e MONGODB_URI="your_mongodb_uri" \
  -e JWT_SECRET="your_jwt_secret" \
  shophub-backend
```

### Deploy to Docker Hub
```bash
# Tag the image
docker tag shophub-backend your-username/shophub-backend:latest

# Push to Docker Hub
docker push your-username/shophub-backend:latest
```

## ☁️ Other Cloud Platforms

### Heroku
1. Install Heroku CLI
2. Create a new Heroku app
3. Set environment variables:
   ```bash
   heroku config:set MONGODB_URI="your_mongodb_uri"
   heroku config:set JWT_SECRET="your_jwt_secret"
   heroku config:set SPRING_PROFILES_ACTIVE="prod"
   ```
4. Deploy: `git push heroku main`

### Railway
1. Connect your GitHub repository
2. Set environment variables in Railway dashboard
3. Railway will automatically detect and deploy the Spring Boot app

### Google Cloud Platform
1. Use Google Cloud Build with the provided Dockerfile
2. Deploy to Cloud Run or Compute Engine

## 🔧 Configuration Files

### Application Properties
- `application.properties` - Default configuration
- `application-prod.properties` - Production-specific settings

### Build Configuration
- `pom.xml` - Maven configuration with corrected source directories
- `render-build.sh` - Render-specific build script
- `render.yaml` - Render deployment configuration
- `Dockerfile` - Docker containerization

## 🏥 Health Checks

The application includes Spring Boot Actuator for health monitoring:
- Health endpoint: `/actuator/health`
- Info endpoint: `/actuator/info`

## 🔒 Security Considerations

1. **Environment Variables**: Never commit sensitive data like database URLs or JWT secrets
2. **CORS**: Configure allowed origins for your frontend domain
3. **HTTPS**: Always use HTTPS in production
4. **Database Security**: Use strong passwords and restrict database access

## 🐛 Troubleshooting

### Common Issues

1. **Build Fails - mvnw not found**
   - Ensure `mvnw` is executable: `chmod +x ./mvnw`
   - Check that `.mvn/wrapper/maven-wrapper.properties` exists

2. **Application Won't Start**
   - Check MongoDB connection string
   - Verify environment variables are set
   - Check logs for specific error messages

3. **Health Check Fails**
   - Ensure Spring Boot Actuator dependency is included
   - Check that `/actuator/health` endpoint is accessible
   - Verify port configuration

### Logs and Monitoring
- Check application logs in your deployment platform
- Use the health endpoint to monitor application status
- Monitor database connections and performance

## 📝 Next Steps

1. Set up CI/CD pipeline for automatic deployments
2. Configure monitoring and alerting
3. Set up database backups
4. Implement proper logging and error tracking
5. Add integration tests for deployment validation
