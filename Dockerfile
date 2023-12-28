FROM node:19.2-alpine3.16
# /app

#cd
WORKDIR /app

#Dest /app
COPY app.js package.json ./

#ejecutar comandos
RUN npm install

#comando de aplicacion
CMD [ "node","app.js" ]

