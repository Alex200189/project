FROM node:18-alpine AS builder
WORKDIR /app
COPY package.json ./
RUN npm install
COPY src/ ./src/
RUN npm test

FROM node:18-alpine AS runner
WORKDIR /app
ENV NODE_ENV=production
COPY --from=builder /app/package.json ./
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/src ./src
EXPOSE 3000
CMD ["npm", "start"]


