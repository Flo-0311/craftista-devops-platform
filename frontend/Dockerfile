FROM node:latest as build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .

FROM node:alpine
RUN adduser -D appuser
USER appuser
WORKDIR /app
COPY --from=build /app .
EXPOSE 3000
CMD ["node", "app.js"]
