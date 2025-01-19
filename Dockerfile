# Author: Randolph William Aarseth II <randolph@divine.games>
# Project: Blazium Engine
# Description: Dockerfile for deploying web-exported games using Nginx.
# Base Image: Nginx latest

# Use the official Nginx image as a base
FROM nginx:latest

# Maintainer metadata
LABEL maintainer="Randolph William Aarseth II <randolph@divine.games>"
LABEL project="Blazium Engine"
LABEL description="Dockerfile for deploying web-exported games using Nginx."

# Copy custom Nginx configuration file to replace the default config
COPY nginx/nginx.conf /etc/nginx/nginx.conf

# Copy all content from the "static" folder to Nginx's HTML directory
COPY static/ /usr/share/nginx/html/

# Expose port 8080 to the Docker host
EXPOSE 8080

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
