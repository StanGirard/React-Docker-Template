FROM node:10-alpine as builder
RUN apk add --no-cache git
RUN git clone https://github.com/StanGirard/ReactBoilerplate ReactBoilerplate
WORKDIR /ReactBoilerplate
RUN npm install babel-polyfill
RUN npm install --only=prod

RUN npm run build

# ------------------------------------------------------
# Production Build
# ------------------------------------------------------
FROM nginx
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /ReactBoilerplate/build /usr/share/nginx/html
