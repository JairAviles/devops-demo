FROM node:8.11.2
EXPOSE 3000

WORKDIR /app

ADD package.json /app/
RUN npm install

ADD . /app/

CMD ["node", "server"]

