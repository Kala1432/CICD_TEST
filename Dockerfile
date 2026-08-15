# Stage 1: Build (if needed for static files)
FROM node:18-alpine AS builder
WORKDIR /app
COPY . .
# For static files, we can optionally minify or optimize
# For now, we'll just copy as-is

# Stage 2: Serve with Nginx
FROM nginx:alpine
LABEL maintainer="your-email@example.com"
LABEL description="Static HTML login page served with Nginx"

# Copy static files to Nginx
COPY --from=builder /app /usr/share/nginx/html/

# Copy custom Nginx config (optional - for better performance)
COPY nginx.conf /etc/nginx/nginx.conf

# Expose port 80
EXPOSE 80

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
  CMD wget --quiet --tries=1 --spider http://localhost/ || exit 1

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
