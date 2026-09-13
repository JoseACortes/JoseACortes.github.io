#!/usr/bin/env bash
#
# run.sh — Serve the JoseACortes.github.io site locally for preview.
#
# The site is plain HTML/CSS, so any static file server works.
# This script prefers Python's built-in http.server (no dependencies).
#
# Usage:
#   ./run.sh            # serve on default port 8000
#   ./run.sh 8080       # serve on a custom port
#
# Then open http://localhost:8000 in your browser.

set -euo pipefail

# Resolve the site root (one level up from this `run/` folder).
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SITE_DIR="$(dirname "$SCRIPT_DIR")"

# Port: first argument, or default 8000.
PORT="${1:-8000}"

cd "$SITE_DIR"

echo "Serving site from: $SITE_DIR"
echo "Open: http://localhost:${PORT}"
echo "Press Ctrl+C to stop."
echo

# Prefer python3, fall back to python (Windows may expose it as `python`).
if command -v python3 >/dev/null 2>&1; then
  exec python3 -m http.server "$PORT"
elif command -v python >/dev/null 2>&1; then
  exec python -m http.server "$PORT"
else
  echo "Error: Python not found. Install Python or use another static server." >&2
  exit 1
fi
