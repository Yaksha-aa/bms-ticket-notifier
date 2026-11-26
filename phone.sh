#!/data/data/com.termux/files/usr/bin/bash
# BMS watcher for Android (Termux). Keep Termux open; press Ctrl+C to stop.
cd "$(dirname "$0")" || exit 1

export BMS_STATE_FILE="$HOME/.bms_state.json"

termux-wake-lock 2>/dev/null
echo "🎬 BMS watcher started. Keep Termux open. Ctrl+C to stop."

while true; do
  # Pick up any settings/code updates pushed to GitHub (ignored if offline)
  git pull -q --ff-only >/dev/null 2>&1
  source ./phone.env
  python main.py
  sleep "${INTERVAL:-120}"
done
