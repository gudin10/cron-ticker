#Trae la version de node alpine
#FROM --platform=linux/arm64 node:19.2-alpine3.16
#docker buildx build --platform linux/amd64, linux/arm64, linux/arm64/v7, linux/arm64/v8 \
#-t intydocker21/cron-ticker --push .
#$BUILDPLATFORM : Para especificar la plataforma
FROM node:19.2-alpine3.16
# /app

#cd
WORKDIR /app

#Dest /app
COPY package.json ./

#ejecutar comandos
RUN npm install

#Dest /app
#COPY app.js ./ copia todo lo que esta en mi proyecto y la raiz de la imagen del workdir
COPY . .

#Realizar testing
RUN npm run test

#Eliminar archivos y directorios no necesarios en PROD
RUN rm -rf test && rm -rf node_modules

#Unicamente las dependencias de prod
RUN npm install --prod

#comando de inicio de la aplicacion
CMD [ "node","app.js" ]

