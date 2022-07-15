#stage 1 - build
FROM node:16-alpine as builder
WORKDIR '/app'
COPY ./frontend/package.json .
RUN npm install --legacy-peer-deps
COPY ./frontend .
RUN npm run build
# /app/build will have all the stuff we care about

#stage 2 - host
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
#default cmd for nginx container starts nginx looking for content in the /usr/share/nginx/html area!

EXPOSE 80

# build with default multi-step "dockerfile" in pwd
# docker build -t multipass . 
