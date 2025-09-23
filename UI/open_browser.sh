#!/bin/bash

URL="http://localhost:3000"

# Wait until UI server is responding
echo "Waiting for UI to start at $URL..."
until curl -s "$URL" > /dev/null; do
  sleep 2
done

# open in default
if command -v xdg-open > /dev/null; then
  xdg-open "$URL"
elif command -v open > /dev/null; then
  open "$URL"
elif command -v start > /dev/null; then
  start "$URL"
else
  echo "Open your Google Chrome and visit: $URL (Not internet explorer)"
fi
