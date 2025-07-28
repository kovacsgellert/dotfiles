#!/bin/bash

# Check if kanata.service is active
if systemctl --user is-active --quiet kanata.service; then
  echo '{"text": "kanata", "class": "running", "tooltip": "kanata.service is active"}'
else
  echo '{"text": "kanata", "class": "stopped", "tooltip": "kanata.service is inactive"}'
fi
