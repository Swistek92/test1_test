# ---------- STAGE 1: BUILD ----------
FROM node:20-alpine AS builder

WORKDIR /app

# kopiujemy zależności
COPY package*.json ./
RUN npm ci

# kopiujemy resztę projektu
COPY . .

# build aplikacji Vite (tworzy dist/)
RUN npm run build


# ---------- STAGE 2: PRODUCTION SERVER ----------
FROM nginx:alpine

# usuwamy default config
RUN rm -rf /usr/share/nginx/html/*

# kopiujemy zbudowaną apkę
COPY --from=builder /app/dist /usr/share/nginx/html

# SPA routing fix (React Router etc.)
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
