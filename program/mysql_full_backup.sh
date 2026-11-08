#!/bin/bash
# ============================================================
# FULL BACKUP - MariaDB
# Dijalankan setiap hari jam 02:00
# ============================================================

DATE=$(date +%F)
BASE_DIR="/backup/mysql/${DATE}"
FULL_DIR="${BASE_DIR}/full"
LOG_FILE="/var/log/mariadb_backup.log"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOG_FILE"
}

log "====== MULAI FULL BACKUP ======"

# Buat direktori
mkdir -p "$FULL_DIR"

# Jalankan full backup
if mariabackup --backup \
    --target-dir="$FULL_DIR" \
    >> "$LOG_FILE" 2>&1; then

    # Prepare full backup agar siap jadi base incremental
    mariabackup --prepare \
        --apply-log-only \
        --target-dir="$FULL_DIR" \
        >> "$LOG_FILE" 2>&1

    log "Full backup BERHASIL: $FULL_DIR"
else
    log "Full backup GAGAL!"
    exit 1
fi

# Hapus backup lebih dari 7 hari
find /backup/mysql -mindepth 1 -maxdepth 1 -type d -mtime +7 -exec rm -rf {} \;
log "Cleanup backup lama selesai"
log "====== SELESAI FULL BACKUP ======"