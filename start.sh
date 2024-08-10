#!/bin/sh

# Start Node.js application in the background
node app.js &

# Start Nginx in the foreground
nginx -g 'daemon off;'
