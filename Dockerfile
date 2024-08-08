# Stage 1: Build Node.js Application
FROM node:14 as builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .

# Stage 2: Set up Nginx Reverse Proxy
FROM nginx:alpine
COPY --from=builder /app /app
RUN nginx -t
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

