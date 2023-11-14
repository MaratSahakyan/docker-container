FROM node:latest AS dependencies
WORKDIR /home/app
COPY ./nest-order-service/package.json ./
COPY ./nest-order-service/ormconfig.ts ./
COPY ./nest-order-service/tsconfig.json ./

# RUN npm install
RUN yarn install

FROM node:latest AS builder

WORKDIR /home/app
COPY --from=dependencies /home/app/node_modules ./node_modules
COPY ./nest-order-service .
COPY ./nest-order-service/tsconfig.json ./
COPY ./nest-order-service/tsconfig.build.json ./
COPY ./nest-order-service/ormconfig.ts ./
ENV NODE_ENV production
RUN yarn build

# remove unused dependencies
RUN rm -rf node_modules/rxjs/src/
RUN rm -rf node_modules/rxjs/bundles/
RUN rm -rf node_modules/rxjs/_esm5/
RUN rm -rf node_modules/rxjs/_esm2015/
RUN rm -rf node_modules/swagger-ui-dist/*.map


FROM node:latest AS runner
WORKDIR /home/app

COPY --from=builder /home/app/node_modules ./node_modules
COPY --from=builder /home/app/dist ./dist
COPY --from=builder /home/app/ormconfig.ts ./

EXPOSE 4004
ENV PORT 4004
CMD ["node", "dist/src/main.js" ]

