#!/bin/bash
set -e

echo "[startup] Installing Python dependencies..."
pip install --quiet -r bot/requirements.txt 2>&1 | tail -3

echo "[startup] Updating yt-dlp to latest..."
pip install --quiet --upgrade yt-dlp 2>&1 | tail -2

echo "[startup] Starting Telegram bot in background..."
bash bot/run.sh &
BOT_PID=$!
echo "[startup] Bot started with PID $BOT_PID"

echo "[startup] Starting API server on port ${PORT}..."
exec node --enable-source-maps artifacts/api-server/dist/index.mjs
