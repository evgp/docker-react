#build phase

FROM node:alpine as builder

WORKDIR /app

COPY package.json .
RUN npm install

COPY . .

RUN npm run build

# /app/build < --- all the stuff we need for production
# Run Phase

FROM nginx
# exposing port through the Dockerfile
EXPOSE 80

# copying something from the builder phase
COPY --from=builder /app/build /usr/share/nginx/html
# to htmlroot directory of nginx

