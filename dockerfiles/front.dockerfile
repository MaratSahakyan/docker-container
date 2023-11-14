# Stage 1: Build dependencies
FROM node:18 AS dependencies
WORKDIR /app
COPY ./vue-order-service/package.json ./
COPY ./vue-order-service/yarn.lock ./
RUN yarn install

# Stage 2: Build Quasar project
FROM node:18 AS builder
WORKDIR /app
COPY --from=dependencies /app/node_modules ./node_modules
COPY ./vue-order-service .
ENV NODE_ENV production
RUN yarn build

# Stage 3: Create production image with NGINX
FROM nginx:alpine AS production
WORKDIR /usr/share/nginx/html
COPY --from=builder /app/dist/spa .

# Add a non-root user
RUN adduser -D myuser
USER myuser

# Expose port 8081 inside the container
EXPOSE 8081
CMD ["nginx", "-g", "daemon off;"]



