FROM node:20-alpine AS build
WORKDIR /app

COPY package*.json ./

RUN npm install

#kopiujemy wszystko z "tego miejsca" do "miejsca w kontenerze"
COPY . .

RUN npm run build

FROM nginx:stable-alpine
# Kopiujemy zbudowane pliki z poprzedniego etapu do folderu Nginx
COPY --from=build /app/dist /usr/share/nginx/html
#otwieramy port 80
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
