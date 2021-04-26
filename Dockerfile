##   ##
FROM node:10-alpine as build

WORKDIR /app
COPY package.json /app

RUN npm install --silent
COPY . .

RUN npm run build
CMD ["npm", "start"]


##    ##
FROM nginx:1.17.1-alpine
COPY --from=build /app/build /usr/share/nginx/html
COPY nginx/nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80 

CMD ["nginx", "-g", "daemon off;"]
