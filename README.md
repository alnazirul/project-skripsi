# Implementasi dan Analisis Otomatisasi Backup Data pada Jaringan Hybrid Sistem Pemeriksaan Pasien Rawat Inap di Rumah Sakit

## Deskripsi

Repository ini berisi implementasi dan analisis sistem otomatisasi backup database untuk mendukung keamanan dan ketersediaan data pada sistem pemeriksaan pasien rawat inap di rumah sakit.

Penelitian ini menggunakan arsitektur replikasi database **MariaDB Master-Slave** pada lingkungan Virtual Private Server (VPS). Server Master berfungsi sebagai server utama yang menerima transaksi dan perubahan data, sedangkan server Slave berfungsi sebagai replika database.

Proses pencadangan data dilakukan menggunakan **MariaDB Backup** dengan penjadwalan otomatis melalui **Cron Job** pada sistem operasi Linux. Pendekatan ini bertujuan untuk mengurangi ketergantungan terhadap proses backup manual serta memastikan ketersediaan salinan data secara berkala.

## Teknologi yang Digunakan

- MariaDB 10.6
- MariaDB Master-Slave Replication
- MariaDB Backup
- Linux Ubuntu Server
- Virtual Private Server (VPS)
- Cron Job Scheduling
- Bash Shell Scripting

## Tujuan Penelitian

1. Mengimplementasikan replikasi database menggunakan arsitektur Master-Slave.
2. Mengimplementasikan otomatisasi backup database menggunakan MariaDB Backup.
3. Mengatur jadwal backup secara otomatis menggunakan Cron Job.
4. Menganalisis performa dan efektivitas proses backup berdasarkan waktu eksekusi dan keterlambatan replikasi.

## Parameter Pengujian

- **Average Backup Time:** Rata-rata waktu yang dibutuhkan untuk melakukan proses backup.
- **Seconds Behind Master:** Mengukur keterlambatan sinkronisasi antara server Master dan Slave.

Repository ini dikembangkan sebagai bagian dari penelitian tugas akhir (skripsi).
