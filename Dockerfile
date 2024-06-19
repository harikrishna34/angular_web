# Stage 1: Build the Angular application
FROM node:18.19.0 AS build
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm cache clean --force && npm install --legacy-peer-deps
COPY . .
RUN npm install -g @angular/cli && ng build --prod

# Stage 2: Serve the application using Nginx
FROM nginx:alpine
COPY --from=build /app/dist/your-angular-app /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
