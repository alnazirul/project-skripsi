#!/bin/bash

# ============================================================
# Replication Lag Monitor — Output ke CSV
# Lokasi output: /home/alnazirul/replication_lag_<tanggal>.csv
# ============================================================

OUTPUT_DIR="/home/alnazirul"
DATE_TAG=$(date '+%Y-%m-%d')
CSV_FILE="${OUTPUT_DIR}/replication_lag_${DATE_TAG}.csv"

# Tulis header CSV jika file belum ada
if [ ! -f "$CSV_FILE" ]; then
    echo "timestamp,replication_lag_ms" > "$CSV_FILE"
    echo "File CSV dibuat: $CSV_FILE"
fi

echo "Monitoring dimulai. Tekan Ctrl+C untuk berhenti."
echo "Data disimpan di: $CSV_FILE"
echo "---------------------------------------------------"

while true; do
    RESULT=$(mysql -u root -p'skripsimembunuhmu123!@#' \
      --silent --skip-column-names -e \
      "SELECT ROUND(
         TIMESTAMPDIFF(MICROSECOND,
           STR_TO_DATE(ts, '%Y-%m-%dT%H:%i:%s.%f'),
           NOW(6)
         ) / 1000, 3
       ) AS lag_ms
       FROM monitor.heartbeat;" 2>/dev/null)

    TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

    # Tampilkan di terminal
    echo "${TIMESTAMP} | Replication Lag: ${RESULT} ms"

    # Tulis ke CSV
    echo "${TIMESTAMP},${RESULT}" >> "$CSV_FILE"

    sleep 1
done