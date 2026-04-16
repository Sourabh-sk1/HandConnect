# HandConnect Dockerfile
# Multi-stage build for optimized production image

# Stage 1: Build stage (if needed for future enhancements)
FROM node:18-alpine AS builder

# Set working directory
WORKDIR /app

# Copy package files if they exist
COPY package*.json ./

# Install dependencies if package.json exists
RUN if [ -f package.json ]; then npm ci --only=production; fi

# Copy application files
COPY . .

# Stage 2: Production stage
FROM nginx:alpine AS production

# Install additional tools for health checks
RUN apk add --no-cache curl

# Copy custom nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Create app directory
WORKDIR /usr/share/nginx/html

# Copy application files from builder stage
COPY --from=builder /app .

# Ensure index.html exists and is accessible
RUN if [ ! -f index.html ]; then \
        echo "Error: index.html not found in the project root"; \
        exit 1; \
    fi

# Set proper permissions
RUN chown -R nginx:nginx /usr/share/nginx/html && \
    chmod -R 755 /usr/share/nginx/html

# Create health check script
RUN echo '#!/bin/sh' > /healthcheck.sh && \
    echo 'curl -f http://localhost/ || exit 1' >> /healthcheck.sh && \
    echo 'curl -f http://localhost/index.html || exit 1' >> /healthcheck.sh && \
    chmod +x /healthcheck.sh

# Expose port 80
EXPOSE 80

# Add health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD /healthcheck.sh

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
