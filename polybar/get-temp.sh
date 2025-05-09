#!/bin/bash

cpu_temp=$(sensors | awk '/Tctl:/ {print $2}')
gpu_temp=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits | head -n 1)

echo "CPU $cpu_temp | GPU ${gpu_temp}°C"
