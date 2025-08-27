#!/bin/bash
# Simula datos de un inversor solar
POWER=$(( (RANDOM % 5000) + 100 ))   # 100W - 5100W
VOLTAGE=$(( (RANDOM % 50) + 300 ))   # 300V - 350V
TEMP=$(( (RANDOM % 20) + 25 ))       # 25°C - 45°C

echo "solar_metrics power=$POWER,voltage=$VOLTAGE,temp=$TEMP"
