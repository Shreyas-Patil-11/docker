# Use a small, fast base image with Nginx
FROM nginx:alpine

# Remove the default Nginx website
RUN rm -rf /usr/share/nginx/html/*

# Copy our static site to Nginx's web directory
COPY . /usr/share/nginx/html

# Expose port 80 (Nginx default)
EXPOSE 80

# Nginx is started by default in this image with the default command
