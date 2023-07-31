FROM --platform=$BUILDPLATFORM node:18.3.0 AS build

WORKDIR /app

COPY package.json ./
COPY yarn.lock ./

RUN yarn install

COPY . .

RUN yarn build

FROM node:18.3.0

WORKDIR /app

COPY --from=build /app/dist /app

EXPOSE 3000

ENTRYPOINT ["npx", "serve", "-s", "."]