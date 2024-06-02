# Stage 1: Build backend
FROM node:13.14.0-alpine3.11 AS backend

WORKDIR /usr/src/app/backend

COPY ./backend .

# Stage 2: Build client
FROM node:13.14.0-alpine3.11 AS client

WORKDIR /usr/src/app/client

COPY ./client .

# Stage 3: Combine and serve
FROM node:13.14.0-alpine3.11 AS prod

# Set the working directory to /var/www
WORKDIR /var/www

# Copy the backend and client from the respective stages
COPY --from=client /usr/src/app/client ./client
COPY --from=backend /usr/src/app/backend ./backend

# Expose the ports
EXPOSE 3000
EXPOSE 5001

COPY ./package*.json  ./

# Set the working directory to /var/www/backend and install production dependencies
RUN npm run install-all


# Run the application
CMD [ "npm", "run", "dev"]
