# Step 1: Nodejs image to build
# also known as base image
FROM node:18-alpine as build

WORKDIR /app
COPY package*.json .
RUN npm install

COPY . .

RUN npm run build

# step 2: Nginx image to server build app

FROM nginx:alpine
COPY --from=build /app/dist /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]