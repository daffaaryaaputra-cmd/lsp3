#!/usr/bin/env bash
set -u

echo "===== STATUS LAYANAN ====="
for service in ssh mariadb apache2 bind9; do
  if systemctl is-active --quiet "$service"; then
    echo "[AKTIF] $service"
  else
    echo "[TIDAK AKTIF] $service"
  fi
done

echo
echo "===== VALIDASI APACHE ====="
if command -v apache2ctl >/dev/null 2>&1; then
  sudo apache2ctl configtest
else
  echo "apache2ctl belum tersedia."
fi

echo
echo "===== VALIDASI BIND9 ====="
if command -v named-checkconf >/dev/null 2>&1; then
  sudo named-checkconf
  echo "named-checkconf selesai. Jika tidak ada pesan error, konfigurasi dasar valid."
else
  echo "named-checkconf belum tersedia."
fi

echo
echo "===== INFORMASI JARINGAN ====="
ip -br address
ip route

echo
echo "===== TES HTTP LOKAL ====="
if command -v curl >/dev/null 2>&1; then
  curl -I --max-time 5 http://127.0.0.1/ || true
else
  echo "curl belum tersedia."
fi

echo
echo "Pemeriksaan selesai. Pesan error di atas perlu ditangani sebelum melanjutkan."
