# Stage 1: Build the Node.js application
FROM node:18 AS build

# Set working directory
WORKDIR /app

# Copy package.json and install dependencies
COPY src/package.json ./
RUN npm install

# Copy the application code
COPY src/ ./

# Stage 2: Nginx setup
FROM nginx:alpine

# Copy the built Node.js application from the first stage
COPY --from=build /app /app

# Copy Nginx configuration
COPY nginx/nginx.conf /etc/nginx/nginx.conf

# Install Node.js in the final Nginx image
RUN apk add --no-cache nodejs npm

# Change the working directory
WORKDIR /app

# Expose both Nginx and Node.js ports
EXPOSE 80

# Start both Node.js and Nginx together using a simple script
COPY scripts/start.sh /start.sh
RUN chmod +x /start.sh

# Run the script to start both services
CMD ["/start.sh"]

