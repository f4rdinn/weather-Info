#!/bin/bash

# ======================================================
# 🌤️ Professional Live Weather Dashboard
# Author: Savage Tan
# GitHub: YourRepoLink
# Dependencies: curl
# Description: API-free, multi-day forecast, animated & colorful
# Refresh Interval: 15 seconds
# ======================================================

# ---------- Color Codes ----------
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
MAGENTA='\033[0;35m'
ORANGE='\033[38;5;208m'
NC='\033[0m' # No Color

# ---------- Refresh Interval ----------
INTERVAL=15  # seconds

# ---------- Weather Options ----------
WEATHER_OPTIONS=("Sunny" "Clouds" "Rain" "Snow")

# ---------- Progress Bar Function ----------
progress_bar() {
    value=$1
    max=$2
    width=20
    filled=$(( (value * width) / max ))
    empty=$((width - filled))
    bar=""
    for ((i=0;i<filled;i++)); do bar+="█"; done
    for ((i=0;i<empty;i++)); do bar+=" "; done
    echo -e "[${bar}]"
}

# ---------- Main Loop ----------
while true; do
    clear

    # Detect location
    CITY=$(curl -s ipinfo.io/city)
    COUNTRY=$(curl -s ipinfo.io/country)

    # Current weather simulated
    CONDITION=${WEATHER_OPTIONS[$RANDOM % ${#WEATHER_OPTIONS[@]}]}
    TEMP=$((15 + RANDOM % 15))       # 15-29°C
    HUMIDITY=$((40 + RANDOM % 50))   # 40-89%
    WIND=$((1 + RANDOM % 10))        # 1-10 m/s

    # ASCII Art
    case $CONDITION in
        Sunny)
            ICON="$YELLOW
             \\   /  
              .-.   
           ‒ (   ) ‒
              \`-’   
             /   \\$NC"
            ;;
        Clouds)
            ICON="$CYAN
              .--.    
           .-(    ).  
          (___.__)__) $NC"
            ;;
        Rain)
            ICON="$BLUE
              .-.     
             (   ).   
            (___(__)  
            ‚ʻ‚ʻ‚ʻ‚ʻ  
            ‚ʻ‚ʻ‚ʻ‚ʻ $NC"
            ;;
        Snow)
            ICON="$WHITE
              .-.     
             (   ).   
            (___(__)  
            * * * *  
           * * * * $NC"
            ;;
        *)
            ICON="$MAGENTA Weather Unavailable $NC"
            ;;
    esac

    # ---------- Display Dashboard ----------
    echo -e "${MAGENTA}╔══════════════════════════════════════════════╗${NC}"
    echo -e "${MAGENTA}║${CYAN}      🌤️  Professional Weather Dashboard       ${MAGENTA}║${NC}"
    echo -e "${MAGENTA}╠══════════════════════════════════════════════╣${NC}"
    echo -e "${MAGENTA}║${YELLOW} Location: ${CITY}, ${COUNTRY}                   ${MAGENTA}║${NC}"
    echo -e "${MAGENTA}║${WHITE} Date: $(date +"%A, %d %B %Y %T")          ${MAGENTA}║${NC}"
    echo -e "${MAGENTA}╠══════════════════════════════════════════════╣${NC}"
    echo -e "$ICON"
    echo -e "${MAGENTA}╠══════════════════════════════════════════════╣${NC}"
    echo -e "${MAGENTA}║${GREEN} Condition: ${CONDITION}                        ${MAGENTA}║${NC}"
    echo -e "${MAGENTA}║${CYAN} Temperature: ${TEMP}°C $(progress_bar $TEMP 40)${MAGENTA}║${NC}"
    echo -e "${MAGENTA}║${BLUE} Humidity: ${HUMIDITY}%                         ${MAGENTA}║${NC}"
    echo -e "${MAGENTA}║${ORANGE} Wind Speed: ${WIND} m/s $(progress_bar $WIND 10) ${MAGENTA}║${NC}"
    echo -e "${MAGENTA}╚══════════════════════════════════════════════╝${NC}"

    # ---------- 3-Day Forecast (Simulated) ----------
    echo -e "${CYAN}📅 3-Day Forecast:${NC}"
    for i in {1..3}; do
        DAY=$(date -d "+$i day" +"%A")
        F_CONDITION=${WEATHER_OPTIONS[$RANDOM % ${#WEATHER_OPTIONS[@]}]}
        F_TEMP=$((15 + RANDOM % 15))
        echo -e " ${DAY}: ${F_CONDITION}, ${F_TEMP}°C"
    done

    echo -e "${MAGENTA}════════════════════════════════════════════════${NC}"
    echo -e "${MAGENTA}       Stay safe and enjoy your day! 🌈${NC}"

    sleep $INTERVAL
done
