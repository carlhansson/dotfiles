#!/bin/bash

location=$(curl -s https://ipinfo.io/city)

if [ -z "$location" ]; then
    location="Stockholm"
fi

wttrbar --location "$location" --lang sv --observation-time