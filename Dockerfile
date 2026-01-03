# Build stage för React
FROM node:22-alpine AS builder
WORKDIR /app

# Increase Node.js memory limit for large dependency trees
ENV NODE_OPTIONS="--max-old-space-size=4096"

COPY package*.json ./

# Install all dependencies (including devDependencies for build)
# NODE_ENV=development ensures devDependencies are installed even if Coolify sets NODE_ENV=production
RUN NODE_ENV=development npm install --legacy-peer-deps

COPY . .
RUN npm run build

# Production stage
FROM node:22-alpine
WORKDIR /app

# Copy package.json first (needed for npm prune)
COPY package*.json ./

# Copy node_modules from builder (avoids parallel npm install issue)
COPY --from=builder /app/node_modules ./node_modules

# Remove dev dependencies to slim down the image
RUN npm prune --omit=dev

# Kopiera byggd React-app från builder
COPY --from=builder /app/build ./build

# Kopiera server-filen
COPY server.mjs .

# Exponera port
EXPOSE 5555

# Starta servern
CMD ["node", "server.mjs"]
