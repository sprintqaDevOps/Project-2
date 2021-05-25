FROM node:carbon
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 8095 22 443 80 
CMD [ "npm", "start" ]
