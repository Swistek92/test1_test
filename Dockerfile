FROM node:20-alpine

WORKDIR /app

# deps
COPY package*.json ./
RUN npm ci

# app
COPY . .

# build
RUN npm run build

# vite preview domyślnie słucha na 4173
EXPOSE 4173

# ważne: --host 0.0.0.0 żeby było dostępne z zewnątrz kontenera
CMD ["npm", "run", "preview", "--", "--host", "0.0.0.0", "--port", "4173"]
