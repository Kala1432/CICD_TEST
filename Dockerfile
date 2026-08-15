FROM nginx:alpine

LABEL description="Static HTML website served with Nginx"

# Copy website files
COPY . /usr/share/nginx/html/

# Nginx HTTP port
EXPOSE 80

# Container health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD wget --quiet --tries=1 --spider http://localhost/ || exit 1

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]