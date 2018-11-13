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
# but on a local machine this instruction not works automatically. Means nothing for developer.
# elastic beanstalk looks for this instruction and going to map it directly automatically 
EXPOSE 80

# copying something from the builder phase
COPY --from=builder /app/build /usr/share/nginx/html
# to htmlroot directory of nginx

