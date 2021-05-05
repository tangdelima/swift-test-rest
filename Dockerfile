FROM node:16-alpine3.11

ADD server.js package.json package-lock.json /

RUN npm install

EXPOSE 3000:3000

CMD npm run start