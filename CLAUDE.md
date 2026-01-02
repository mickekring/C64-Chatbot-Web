# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

C64 Chatbot - A retro Commodore 64 terminal emulator that chats with OpenAI. The AI persona "Vic" role-plays as a C64 operating system from 1985.

## Commands

### Development
```bash
npm start              # Start React dev server (port 3000, proxies to backend)
node server.mjs        # Start Express backend (port 5555)
```
Run both simultaneously for local development.

### Build & Test
```bash
npm run build          # Production build to /build
npm test               # Run tests (Jest/React Testing Library)
```

### Docker Deployment
```bash
docker compose up -d   # Build and run (serves on port 5555)
```

## Architecture

**Two-process architecture:**
- Frontend: Create React App (React 18) - client-side only, no SSR/RSC
- Backend: Express server (`server.mjs`) - handles API routes

**Frontend (`src/App.js`):**
- Single-component terminal emulator with inline styles
- 40-character line width (C64 standard)
- Typewriter animation for AI responses
- BASIC command emulation (LIST, RUN, HELP, etc.)
- Password-protected chat mode (LOAD CHAT → password → chat)

**Backend (`server.mjs`):**
- `POST /api/chat` - Proxies to OpenAI (gpt-4o-mini)
- `POST /api/verify-password` - Validates against C64_PASSWORD env var
- `GET /api/health` - Health check
- In production: serves static React build

**Proxy Configuration:**
`package.json` has `"proxy": "http://localhost:5555"` for development.

## Environment Variables

Copy `.env.example` to `.env`:
- `OPENAI_API_KEY` - Required for chat
- `C64_PASSWORD` - Chat access password (default: pass123)
- `PORT` - Server port (default: 5555)
- `NODE_ENV` - Set to `production` to serve static files

## Visual Style

- VT323 monospace font (Google Fonts)
- C64 color scheme: blue background (#4756e5), light blue border (#8e91fb)
- User text: white, AI text: yellow (#d5df7c), System text: light blue (#9F9FFF)
