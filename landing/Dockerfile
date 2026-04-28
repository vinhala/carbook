FROM node:24-alpine AS deps

WORKDIR /app

COPY package.json package-lock.json* ./
RUN if [ -f package-lock.json ]; then npm ci; else npm install; fi

FROM node:24-alpine AS build

WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY . .
RUN npm run build

FROM node:24-alpine AS runner

ENV NODE_ENV=production \
    HOST=0.0.0.0 \
    PORT=80

WORKDIR /app
COPY --from=build /app/.output ./.output

EXPOSE 80

CMD ["node", ".output/server/index.mjs"]
