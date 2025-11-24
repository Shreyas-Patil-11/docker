# Dockerfile to build a simple, production-ready Nginx container for a static website.

# STAGE 1: Builder Stage (Only needed if the app required compilation/building, but good practice)
# We start with a base image that is suitable for building (though not strictly necessary for simple HTML/CSS)
FROM node:20-slim as builder

# Set the working directory for the builder
WORKDIR /app

# Copy the static files (only index.html in this case)
COPY index.html .

# STAGE 2: Production Stage
# Use a very minimal and secure Nginx image
FROM nginx:alpine

# Remove the default Nginx index.html file
RUN rm /usr/share/nginx/html/index.html

# Copy the static content from the builder stage into the Nginx content directory
# This directory is where Nginx looks for files to serve.
COPY --from=builder /app/index.html /usr/share/nginx/html/

# Optional: Copy a custom Nginx configuration file (we'll skip this for simplicity, using the default config)
# COPY nginx.conf /etc/nginx/conf.d/default.conf

# The default Nginx configuration exposes port 80.
EXPOSE 80

# The default command runs Nginx in the foreground.
CMD ["nginx", "-g", "daemon off;"]