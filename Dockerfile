FROM node:18-alpine AS backend

WORKDIR /usr/src/app/backend

COPY ./backend/package*.json ./

RUN npm install --production

COPY ./backend .

FROM node:18-alpine AS client

WORKDIR /usr/src/app/client

COPY ./client/package*.json ./

RUN npm install --production

COPY ./client .

FROM node:18-alpine AS prod

WORKDIR /var/www

COPY --from=client /usr/src/app/client ./client
COPY --from=backend /usr/src/app/backend ./backend

EXPOSE 3000
EXPOSE 5001

WORKDIR /var/www/backend

CMD [ "npm", "dev"]
