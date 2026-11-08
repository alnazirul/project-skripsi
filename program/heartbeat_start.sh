#!/bin/bash
echo "[$(date)] Memulai pt-heartbeat monitoring..."
pt-heartbeat --user=root --password='password' \
  --host=localhost \
  --database=monitor \
  --update \
  --daemonize \
  --table=heartbeat \
  --interval=0.1
echo "[$(date)] pt-heartbeat berjalan di background."
ps aux | grep pt-heartbeat | grep -v grep