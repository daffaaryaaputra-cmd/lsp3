#!/usr/bin/env bash
set -Eeuo pipefail

# Helper awal untuk memasang paket layanan LSP-P3.
# Script ini TIDAK mengubah Netplan, database, VirtualHost, DNS, atau firewall.

if [[ "${EUID}" -ne 0 ]]; then
  echo "Jalankan dengan sudo: sudo bash tools/install-packages.sh"
  exit 1
fi

echo "== Memperbarui daftar paket =="
apt-get update

echo
echo "== Memasang paket utama LSP-P3 =="
apt-get install -y \
  openssh-server \
  mariadb-server mariadb-client \
  apache2 \
  php libapache2-mod-php php-mysql \
  bind9 bind9-utils bind9-dnsutils \
  ufw curl

echo
echo "== Mengaktifkan layanan =="
for service in ssh mariadb apache2 bind9; do
  if systemctl list-unit-files "${service}.service" --no-legend 2>/dev/null | grep -q "${service}.service"; then
    systemctl enable --now "$service"
    echo "[OK] $service aktif"
  else
    echo "[PERINGATAN] Unit $service tidak ditemukan; periksa nama layanan pada versi Ubuntu ini."
  fi
done

echo
echo "Paket utama selesai dipasang."
echo "phpMyAdmin belum dipasang otomatis karena installer dapat meminta pilihan interaktif."
echo "Jika ingin memasangnya, jalankan: sudo apt install phpmyadmin php-mysql"
echo "Script ini tidak mengaktifkan UFW atau mengubah konfigurasi jaringan."
