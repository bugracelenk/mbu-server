FROM node:latest
WORKDIR /app
COPY . .
RUN npm install
EXPOSE 3003
ENTRYPOINT ["node", "server.js"]