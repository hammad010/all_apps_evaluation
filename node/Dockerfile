# Use an official Ubuntu 20.04 image as the base
FROM ubuntu:20.04

# Set environment variables for non-interactive mode
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages including Node.js, npm, and NGINX
RUN apt-get update && \
    apt-get install -y curl && \
    curl -fsSL https://deb.nodesource.com/setup_14.x | bash - && \
    apt-get install -y nodejs && \
    apt-get install -y nginx && \
    rm -rf /var/lib/apt/lists/*

# Configure NGINX
COPY nginx/default /etc/nginx/sites-enabled/
#RUN ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default

# Remove default NGINX index page
#RUN rm /var/www/html/index.nginx-debian.html

# Create a directory for the app
WORKDIR /usr/src/app

# Copy package.json and package-lock.json to the container
COPY package*.json ./

# Install app dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Command to run your application
CMD ["sh", "-c", "node /usr/src/app/index.js", "nginx -g 'daemon off;'"]


