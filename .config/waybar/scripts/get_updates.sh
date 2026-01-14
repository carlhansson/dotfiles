#!/bin/bash

# Get the list of updates from pikaur
# 2>/dev/null suppresses errors/progress messages so they don't break the JSON
updates=$(pikaur -Qua 2>/dev/null)

# Count the lines
count=$(echo "$updates" | wc -l)

# Output valid JSON for Waybar
if [ "$count" -gt 0 ]; then
    # Create a tooltip with the list of packages (escape newlines for JSON)
    tooltip=$(echo "$updates" | sed ':a;N;$!ba;s/\n/\\n/g' | sed 's/"/\\"/g')
    echo "{\"text\": \"$count\", \"tooltip\": \"$tooltip\", \"class\": \"pending\"}"
else
    echo "{\"text\": \"\", \"tooltip\": \"System is up to date\", \"class\": \"updated\"}"
fi