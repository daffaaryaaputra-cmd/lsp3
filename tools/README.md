# Tools LSP-P3

Folder ini berisi script bantu untuk Ubuntu Server.

## 1. Pasang paket utama

Dari folder utama repository:

```bash
sudo bash tools/install-packages.sh
```

Script memasang OpenSSH, MariaDB, Apache/PHP, BIND9, UFW, dan curl, lalu mengaktifkan layanan SSH, MariaDB, Apache2, dan BIND9 jika unit servicenya tersedia.

phpMyAdmin sengaja tidak dipasang otomatis karena proses instalasinya dapat meminta pilihan interaktif.

## 2. Periksa layanan dan konfigurasi

```bash
bash tools/check-services.sh
```

Script memeriksa status layanan, validasi dasar Apache dan BIND9, alamat IP, routing, serta respons HTTP lokal.

## Catatan keamanan dan penggunaan

- Jalankan dari direktori utama repository `lsp3`.
- Baca isi script sebelum menjalankannya.
- Script ini belum mengatur Netplan, database, VirtualHost, DNS zone, atau aturan UFW.
- Buat snapshot VirtualBox sebelum melakukan konfigurasi server lebih lanjut.
- Jangan aktifkan UFW sebelum memastikan aturan SSH sesuai jaringan yang digunakan.
