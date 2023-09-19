FROM node:lts-alpine as builder
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install
COPY . .
RUN chown -R appuser:appgroup /app
USER appuser
RUN mkdir -p /app/dist/assets
RUN npm run build


FROM nginxinc/nginx-unprivileged:stable-alpine3.18-perl
EXPOSE 8080
COPY --from=builder --chown=nginx:nginx /app/dist /usr/share/nginx/html
CMD ["nginx", "-g", "daemon off;"]
