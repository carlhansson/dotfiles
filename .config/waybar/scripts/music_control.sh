#!/bin/bash
PLAYING=$(playerctl -a metadata --format '{{playerName}} {{status}}' \
  | grep -E '^(Feishin|spotify)' \
  | awk '/Playing/{print $1; exit}')

if [ -n "$PLAYING" ]; then
  echo "$PLAYING" > /tmp/last-music-player
  playerctl -p "$PLAYING" pause
else
  PLAYER=$(cat /tmp/last-music-player 2>/dev/null)
  if [ -n "$PLAYER" ]; then
    playerctl -p "$PLAYER" play
  fi
fi