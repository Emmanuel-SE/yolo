# Stage 1: Build backend
FROM node:18-alpine AS backend

WORKDIR /usr/src/app/backend

COPY ./backend/package*.json ./

RUN npm install

COPY ./backend .

# Stage 2: Build client
FROM node:18-alpine AS client

WORKDIR /usr/src/app/client

COPY ./client/package*.json ./

RUN npm install

COPY ./client .

# Stage 3: Combine and serve
FROM node:18-alpine AS prod

# Set the working directory to /var/www
WORKDIR /var/www

# Copy the backend and client from the respective stages
COPY --from=client /usr/src/app/client ./client
COPY --from=backend /usr/src/app/backend ./backend

# Expose the ports
EXPOSE 3000
EXPOSE 5001

WORKDIR /var/www/backend


# Set the working directory to /var/www/backend and install production dependencies
WORKDIR /var/www/backend
RUN npm install 

# Ensure to install production dependencies (optional step, if different from dev dependencies)
RUN npm install 

# Run the application
CMD [ "npm", "run", "dev"]
