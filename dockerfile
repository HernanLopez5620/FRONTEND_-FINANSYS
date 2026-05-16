# FinanSys Frontend — Dockerfile
FROM ghcr.io/cirruslabs/flutter:stable AS builder

WORKDIR /app

COPY . .

RUN flutter pub get

RUN flutter build web --release \
    --dart-define=API_BASE_URL=http://localhost:3000/api/v1

FROM nginx:alpine AS runner
COPY --from=builder /app/build/web /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]