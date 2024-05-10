#!/bin/bash

W_DIR='/opt/krakend_config'


# Start Krakend
krakend run -c /opt/krakend_config/krakend.json

# Notify the systemd service manager that the script has finished starting up
# sd_notify(0, "READY=1")
