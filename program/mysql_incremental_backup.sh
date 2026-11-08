#!/bin/bash
# ============================================================
# INCREMENTAL BACKUP - MariaDB
# Dijalankan jam 09:00, 15:00, 21:00
# ============================================================

DATE=$(date +%F)
HOUR=$(date +%H)
BASE_DIR="/backup/mysql/${DATE}"
FULL_DIR="${BASE_DIR}/full"
LOG_FILE="/var/log/mariadb_backup.log"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOG_FILE"
}

log "====== MULAI INCREMENTAL BACKUP (jam ${HOUR}) ======"

# Tentukan nama folder target berdasarkan jam
case "$HOUR" in
    09) TARGET_DIR="${BASE_DIR}/inc-09"
        ;;
    15) TARGET_DIR="${BASE_DIR}/inc-15"
        ;;
    21) TARGET_DIR="${BASE_DIR}/inc-21"
        ;;
    *)  log "Jam tidak dikenal: $HOUR. Backup dibatalkan."
        exit 1
        ;;
esac

# Tentukan base incremental (dari mana perubahan dihitung)
# Urutan prioritas: inc-15 > inc-09 > full
if   [ -d "${BASE_DIR}/inc-15" ] && [ "$HOUR" == "21" ]; then
    BASE_INC="${BASE_DIR}/inc-15"
elif [ -d "${BASE_DIR}/inc-09" ] && [ "$HOUR" == "15" ]; then
    BASE_INC="${BASE_DIR}/inc-09"
else
    BASE_INC="$FULL_DIR"
fi

# Validasi: full backup harus sudah ada
if [ ! -d "$FULL_DIR" ]; then
    log "ERROR: Full backup tidak ditemukan di $FULL_DIR"
    log "Jalankan full backup terlebih dahulu!"
    exit 1
fi

# Buat direktori target
mkdir -p "$TARGET_DIR"

log "Base incremental: $BASE_INC"
log "Target: $TARGET_DIR"

# Jalankan incremental backup
if mariabackup --backup \
    --target-dir="$TARGET_DIR" \
    --incremental-basedir="$BASE_INC" \
    >> "$LOG_FILE" 2>&1; then

    log "Incremental backup BERHASIL: $TARGET_DIR"
else
    log "Incremental backup GAGAL!"
    exit 1
fi

log "====== SELESAI INCREMENTAL BACKUP (jam ${HOUR}) ======"