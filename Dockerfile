FROM node:lts-alpine as builder
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
WORKDIR /app
COPY package.json package-lock.json ./
RUN chown -R appuser:appgroup .
USER appuser
RUN npm install
COPY . .
RUN mkdir -p dist/assets
RUN chown -R appuser:appgroup dist
RUN npm run build

FROM nginxinc/nginx-unprivileged:stable-alpine3.18-perl
EXPOSE 8080
COPY --from=builder --chown=nginx:nginx /app/dist /usr/share/nginx/html
CMD ["nginx", "-g", "daemon off;"]