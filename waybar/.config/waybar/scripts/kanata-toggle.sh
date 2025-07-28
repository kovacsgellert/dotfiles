#!/bin/bash

# Check if kanata.service is active
if systemctl --user is-active --quiet kanata.service; then
  systemctl --user stop kanata
else
  systemctl --user start kanata
fi
