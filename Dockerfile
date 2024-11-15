# Step 1: Use a Node image to build the app
FROM node:16 AS build

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json files
COPY package*.json ./

# Install dependencies
RUN npm install --legacy-peer-deps

# Copy the rest of the app files
COPY . .

# Build the app
RUN npm run build

# Step 2: Use a lightweight web server image to serve the app
FROM nginx:alpine

# Copy build files to Nginx html folder
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
