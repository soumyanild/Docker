FROM node:12-alpine
RUN apk add --no-cache python2 g++ make
WORKDIR /app
COPY . .
RUN 
Learn more about the "RUN " Dockerfile command.
yarn install --production
CMD ["node", "src/index.js"]
EXPOSE 3000
