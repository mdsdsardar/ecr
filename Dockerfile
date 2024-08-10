# Set working directory
WORKDIR /app

# Copy package.json and install dependencies
COPY package.json ./
RUN npm install

# Copy the application code
COPY . .

# Build step ends here, but we don't start the Node.js server yet

# Stage 2: Nginx setup
FROM nginx:alpine

# Copy the built Node.js application from the first stage
COPY --from=build /app /app

# Copy Nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Install Node.js in the final Nginx image
RUN apk add --no-cache nodejs npm

# Change the working directory
WORKDIR /app

# Expose both Nginx and Node.js ports
EXPOSE 80

# Start both Node.js and Nginx together using a simple script
COPY start.sh /start.sh
RUN chmod +x /start.sh
