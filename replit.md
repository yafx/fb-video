# Facebook Video Telegram Bot

A Telegram bot that downloads Facebook videos and sends them directly in chat, with the original post caption and a custom footer.

## Run & Operate

- `cd bot && python main.py` — run the Telegram bot
- The bot workflow is named **"Telegram Bot"** and starts automatically

## Stack

- Python 3.11
- `python-telegram-bot` — Telegram bot framework (async, polling)
- `yt-dlp` — Facebook video downloading + caption extraction
- `flask` — keep-alive web server for UptimeRobot
- `ffmpeg` — video merging (best video + best audio)

## Where things live

- `bot/main.py` — bot entry point, message handlers
- `bot/downloader.py` — yt-dlp download logic, returns (filepath, caption)
- `bot/keep_alive.py` — Flask server on port 8000 for UptimeRobot

## Architecture decisions

- Videos are downloaded to `/tmp` with a UUID filename to avoid collisions
- Files are deleted immediately in a `finally` block after sending (even on error)
- Caption is truncated to 1024 chars (Telegram limit) with footer preserved
- Flask keep-alive runs as a daemon thread so it doesn't block the bot
- Bot uses long-polling (not webhooks) for simplicity on Replit

## Product

- Send any Facebook video URL → bot downloads it and sends the video file with original caption + "Downloaded by @MyBotName" footer
- Videos over 50 MB are rejected with a helpful message
- Status messages keep the user informed during download/upload

## User preferences

- Bot name footer: `@MyBotName` (change `BOT_NAME` in `bot/main.py` to update)
- UptimeRobot URL: ping your Replit dev URL on port 8000 (e.g. `https://your-repl.repl.co:8000/`)

## Gotchas

- `BOT_NAME` in `bot/main.py` must be updated to match your actual bot username
- Facebook sometimes requires cookies for private/age-restricted videos — yt-dlp may fail on those
- Port 8000 is used for the Flask keep-alive server (8080 is reserved by the mockup sandbox)

## Pointers

- See the `pnpm-workspace` skill for workspace structure, TypeScript setup, and package details
