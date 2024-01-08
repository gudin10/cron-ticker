FROM node:19.2-alpine3.16
# /app

#cd
WORKDIR /app

#Dest /app
COPY package.json ./

#ejecutar comandos
RUN npm install

#Dest /app
#COPY app.js ./
COPY . .

#Realizar testing
RUN npm run test

#Eliminar archivos y directorios no necesarios en PROD
RUN rm -rf test && rm -rf node_modules

#Unicamente las dependencias de prod
RUN npm install --prod

#comando de aplicacion
CMD [ "node","app.js" ]

