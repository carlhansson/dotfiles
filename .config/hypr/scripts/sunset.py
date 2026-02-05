#!/usr/bin/env python3
import datetime
import time
import subprocess
import math
from pysolar.solar import get_altitude
import pytz

# --- CONFIGURATION ---
LAT = 59.36
LON = 18.00
TIMEZONE = "Europe/Stockholm"

# How fast to fade?
TRANSITION_DELAY = 0.   # Seconds between steps (lower = smoother/faster)
TEMP_STEP = 10           # Kelvin change per step (e.g. 10K per tick)
GAMMA_STEP = 0.005       # Gamma change per step

# --- DEFINING THE ZONES ---
# (Elevation Threshold, Target Temp, Target Gamma)
# Order: Highest elevation (Day) to Lowest (Deep Night)
ZONES = [
    (0.0,   6500, 100),   # Day (Above Horizon)
    (-6.0,  5500, 100),   # Sunset -> Civil Twilight
    (-12.0, 4000, 90),   # Civil -> Nautical Twilight
    (-18.0, 3200, 85),  # Nautical -> Astronomical
    (-90.0, 2700, 75),  # Deepest Night (Everything below -18)
]

def get_target_zone(elevation):
    """Finds which zone we are currently in based on sun elevation."""
    for threshold, temp, gamma in ZONES:
        if elevation > threshold:
            return temp, gamma
    # Fallback to the darkest setting if below all thresholds
    return ZONES[-1][1], ZONES[-1][2]

def apply_hyprsunset(temp, gamma):
    """Runs the hyprsunset command."""
    try:
        subprocess.run(
            ["hyprsunset", "--temperature", str(int(temp)), "--gamma", str(gamma)],
            check=False, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL
        )
    except Exception:
        pass

def main():
    # Initial Setup
    tz = pytz.timezone(TIMEZONE)
    
    # We start assuming we are at a standard value to avoid jumping
    current_temp = 6500
    current_gamma = 100
    
    print(f"🌞 Smart Zones Active: {LAT}, {LON}")

    while True:
        # 1. Get Sun Position
        now = datetime.datetime.now(tz)
        elevation = get_altitude(LAT, LON, now)
        
        # 2. Determine where we SHOULD be
        target_temp, target_gamma = get_target_zone(elevation)
        
        # 3. Are we there yet?
        if abs(current_temp - target_temp) > 1 or abs(current_gamma - target_gamma) > 0.001:
            
            # --- TRANSITION LOGIC ---
            # Move Temp
            if current_temp < target_temp:
                current_temp = min(current_temp + TEMP_STEP, target_temp)
            elif current_temp > target_temp:
                current_temp = max(current_temp - TEMP_STEP, target_temp)
                
            # Move Gamma
            if current_gamma < target_gamma:
                current_gamma = min(current_gamma + GAMMA_STEP, target_gamma)
            elif current_gamma > target_gamma:
                current_gamma = max(current_gamma - GAMMA_STEP, target_gamma)

            # Apply and wait a tiny bit for smoothness
            apply_hyprsunset(current_temp, current_gamma)
            time.sleep(TRANSITION_DELAY)
            
        else:
            # 4. We are at the target, so just chill.
            # Check the sun position again in 60 seconds.
            time.sleep(60)

if __name__ == "__main__":
    main()