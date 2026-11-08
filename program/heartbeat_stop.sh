#!/bin/bash
echo "[$(date)] Menghentikan pt-heartbeat..."
kill $(pgrep -f pt-heartbeat) 2>/dev/null
sleep 1
if pgrep -f pt-heartbeat > /dev/null; then
    echo "Gagal dihentikan, coba force kill..."
    kill -9 $(pgrep -f pt-heartbeat)
else
    echo "[$(date)] pt-heartbeat berhasil dihentikan."
fi