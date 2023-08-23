# Use an official Ubuntu 20.04 image as the base
FROM ubuntu:20.04

# Set the working directory in the container
WORKDIR /app

# Install necessary packages including Python and Nginx
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y python3 python3-pip nginx && \
    rm -rf /var/lib/apt/lists/*

# Remove the default Nginx configuration
RUN rm /etc/nginx/sites-enabled/default

# Copy your Nginx configuration file
COPY nginx/default /etc/nginx/sites-enabled/

# Create a symbolic link for the configuration file
#RUN ln -s /etc/nginx/sites-available/nginx.conf /etc/nginx/sites-enabled/

# Copy the requirements file into the container
COPY requirements.txt .

# Install any needed packages specified in requirements.txt
RUN pip3 install -r requirements.txt

RUN service nginx start

# Copy the rest of the application code
COPY . .

# Expose the port your app runs on
EXPOSE 5000

# Command to run your application and start Nginx
CMD ["sh", "-c", "python3  /app/app.py", "nginx"," -g", "daemon off;"]
