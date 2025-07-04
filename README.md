<div align="center">
<img src="https://placehold.co/400x200/0D47A1/FFFFFF?text=Newzly&font=raleway" alt="Logo Newzly">
<h1>Newzly</h1>
<p><strong>Aplikasi berita modern dan lintas-platform yang dibangun dengan Flutter.</strong></p>

<p>
<a href="https://flutter.dev/"><img src="https://img.shields.io/badge/Dibuat%20dengan-Flutter-0175C2.svg" alt="Dibuat dengan Flutter"></a>
<a href="#"><img src="https://img.shields.io/badge/Lisensi-MIT-blue.svg" alt="Lisensi MIT"></a>
</p>

<p>
<img src="https://img.shields.io/badge/Android-3DDC84?style=for-the-badge&logo=android&logoColor=white" alt="Android">
<img src="https://img.shields.io/badge/iOS-000000?style=for-the-badge&logo=ios&logoColor=white" alt="iOS">
<img src="https://img.shields.io/badge/Windows-0078D6?style=for-the-badge&logo=windows&logoColor=white" alt="Windows">
<img src="https://img.shields.io/badge/macOS-000000?style=for-the-badge&logo=apple&logoColor=white" alt="macOS">
<img src="https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black" alt="Linux">
<img src="https://img.shields.io/badge/Web-E34F26?style=for-the-badge&logo=html5&logoColor=white" alt="Web">
</p>
</div>

Newzly adalah aplikasi berita mobile yang dibangun menggunakan Flutter, dirancang untuk berjalan mulus di berbagai platform. Aplikasi ini menyediakan antarmuka yang bersih dan modern bagi pengguna untuk membaca berita terbaru, mengelola artikel mereka sendiri, dan menjelajahi konten berdasarkan kategori.

🌟 Fitur Unggulan
Fitur

Deskripsi

Ikon

Otentikasi Pengguna

Sistem login dan registrasi yang aman untuk melindungi data pengguna.

🔐

Beranda Dinamis

Menampilkan berita terbaru secara real-time dari API.

📰

Pencarian Cepat

Fungsionalitas pencarian di sisi klien untuk memfilter artikel secara instan.

🔍

Jelajah Kategori

Berita dikelompokkan ke dalam kategori untuk navigasi yang mudah.

🗂

Manajemen Artikel

Fitur CRUD (Create, Read, Update, Delete) penuh untuk artikel pengguna.

✍

Manajemen Sesi

Menggunakan shared_preferences untuk menyimpan token, menjaga pengguna tetap login.

🔑

UI/UX yang Mulus

Dilengkapi Splash Screen, dialog konfirmasi, dan pull-to-refresh untuk pengalaman terbaik.

✨

Lintas Platform

Satu basis kode untuk Android, iOS, Web, Windows, macOS, dan Linux.

💻📱

📸 Galeri Aplikasi
<div align="center">
<img src="https://placehold.co/250x500/FFFFFF/333333?text=Layar+Beranda" alt="Layar Beranda" hspace="10">
<img src="https://placehold.co/250x500/FFFFFF/333333?text=Detail+Artikel" alt="Detail Artikel" hspace="10">
<img src="https://placehold.co/250x500/FFFFFF/333333?text=Profil+Pengguna" alt="Profil Pengguna" hspace="10">
</div>

🏗 Arsitektur & Tumpukan Teknologi
Proyek ini mengikuti arsitektur berlapis yang bersih, memisahkan UI, logika bisnis, dan layanan data untuk skalabilitas dan kemudahan pemeliharaan.

Framework: Flutter

Manajemen State: Provider

Jaringan: Paket http

Penyimpanan Lokal: shared_preferences

Arsitektur: MVVM (Model-View-ViewModel) Style

/
├── android/          # Konfigurasi spesifik Android
├── ios/              # Konfigurasi spesifik iOS
├── lib/
│   ├── main.dart     # Entry point, routing, dan inisialisasi
│   ├── models/       # Model data (Contoh: article.dart)
│   ├── providers/    # Manajemen state (Contoh: article_provider.dart)
│   ├── screens/      # Widget untuk setiap layar/halaman UI
│   └── services/     # Logika untuk berinteraksi dengan API
│
└── pubspec.yaml      # Definisi proyek dan dependensi

🚀 Memulai
Untuk menjalankan proyek ini secara lokal, ikuti langkah-langkah berikut:

1. Prasyarat
Pastikan Anda telah menginstal Flutter SDK.

2. Clone Repositori
git clone https://github.com/osaaa27/pemrograman-mobile.git
cd pemrograman-mobile

3. Install Dependensi
flutter pub get

4. Jalankan Aplikasi
Pilih perangkat target Anda (misalnya, chrome, android, ios) dan jalankan aplikasi.

flutter run

Konfigurasi API
Aplikasi ini terhubung ke API di http://45.149.187.204:3000/api. Konfigurasi cleartextTrafficPermitted telah diaktifkan untuk Android agar dapat berjalan selama pengembangan.

<div align="center">
<p>Dibuat dengan ❤ oleh Pengembang Newzly</p>
</div>
