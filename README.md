# Noctura Mobile

Noctura Mobile adalah aplikasi mobile berbasis Flutter yang digunakan oleh pengguna untuk melakukan prediksi gangguan tidur secara mandiri. Aplikasi ini terintegrasi dengan backend Laravel dan database MongoDB melalui REST API.

Repository ini dikhususkan untuk bagian aplikasi mobile Flutter. Aplikasi ini menjadi antarmuka utama pengguna untuk melakukan prediksi, melihat riwayat, mengakses edukasi, serta berinteraksi dengan fitur chatbot berbasis AI.

## Deskripsi Project

Noctura Mobile merupakan aplikasi mobile yang dikembangkan menggunakan Flutter untuk platform Android dan iOS. Aplikasi ini memungkinkan pengguna untuk melakukan prediksi gangguan tidur berdasarkan input yang diberikan, melihat visualisasi hasil prediksi, mengakses konten edukasi, mencatat sleep log, serta berinteraksi dengan chatbot untuk konsultasi ringan seputar gangguan tidur.

Data prediksi yang diinput pengguna dikirimkan ke backend dan disimpan di MongoDB, yang kemudian dapat dipantau oleh admin melalui Noctura Web Admin.

## Tim Pengembang

Nama Tim: Sleep Well

| Nama                          | NIM/Kelas     | Role                                         | GitHub             |
| ----------------------------- | ------------- | -------------------------------------------- | ------------------ |
| [Rizky Wahyu Wangsa Syaelendra](https://github.com/Rizkywhyws) | E31240058 / A | Ketua, Frontend Mobile, Backend Web & Mobile | [@Rizkywhyws](https://github.com/Rizkywhyws) |
| [Doan Sri Washin Sianipar](https://github.com/Doansnpr) | E31240180 / A | Frontend Web, Backend Web & Mobile           | [@Doansnpr](https://github.com/Doansnpr) |
| [Mahmudatul Elisah](https://github.com/elisacis) | E31240350 / A | Frontend Web & Mobile, Backend Web & Mobile  | [@elisacis](https://github.com/elisacis) |
| [Julianda Marselyna](https://github.com/juliandaMarselyna) | E31240410 / A | Frontend Web & Mobile, Backend Web & Mobile  | [@juliandaMarselyna](https://github.com/juliandaMarselyna) |

## Fitur Utama

### 1. Login & Register

Pengguna dapat mendaftarkan akun baru dan masuk ke aplikasi menggunakan email dan kata sandi. Akun dengan role user hanya dapat digunakan melalui aplikasi mobile.

### 2. Dashboard

Halaman utama setelah pengguna berhasil login. Menampilkan ringkasan informasi dan navigasi menuju fitur-fitur utama aplikasi.

### 3. Prediksi Gangguan Tidur

Pengguna dapat melakukan prediksi gangguan tidur dengan mengisi input yang diperlukan. Hasil prediksi dikirimkan ke backend dan disimpan di database MongoDB.

### 4. Riwayat Prediksi

Pengguna dapat melihat riwayat hasil prediksi yang pernah dilakukan sebelumnya.

### 5. Visualisasi

Menampilkan data prediksi dalam bentuk visual (grafik atau chart) untuk memudahkan pengguna memahami pola gangguan tidur mereka.

### 6. Sleep Log

Pengguna dapat mencatat log tidur harian sebagai data tambahan untuk mendukung analisis gangguan tidur.

### 7. Edukasi

Pengguna dapat mengakses konten edukasi mengenai gangguan tidur yang telah dikelola oleh admin melalui web admin.

### 8. Chatbot

Fitur chatbot berbasis AI yang dapat digunakan pengguna untuk berkonsultasi ringan seputar gangguan tidur.

### 9. Profil

Pengguna dapat melihat dan mengelola data profil akun mereka.

## Tech Stack

| Bagian          | Teknologi                      |
| --------------- | ------------------------------ |
| Framework       | Flutter                        |
| Bahasa          | Dart                           |
| Platform        | Android & iOS                  |
| State Management | (sesuaikan dengan yang dipakai) |
| HTTP Client     | Dio / http package             |
| Database Lokal  | SharedPreferences / Hive       |
| Backend API     | Laravel REST API               |
| Database Server | MongoDB                        |

## Struktur Project

```
SLEEP_DETECTION_MOBILE/
├── android/
├── build/
├── ios/
├── linux/
├── macos/
│   ├── Flutter/
│   ├── Runner/
│   ├── Runner.xcodeproj/
│   └── Runner.xcworkspace/
├── lib/
│   ├── chatbot/
│   ├── config/
│   ├── core/
│   ├── dashboard/
│   ├── education/
│   ├── history/
│   ├── login/
│   ├── models/
│   ├── prediction/
│   ├── profile/
│   ├── Register/
│   ├── service/
│   ├── sleep_log/
│   ├── visualization/
│   └── main.dart
```

## Prasyarat Sistem

Sebelum menjalankan project ini, pastikan perangkat sudah memiliki beberapa software berikut:

- Git
- Flutter SDK 3.x+
- Dart SDK (sudah termasuk dalam Flutter)
- Android Studio / VS Code
- Android Emulator atau perangkat fisik Android/iOS
- Xcode (untuk build iOS, khusus macOS)

## Cara Instalasi dan Menjalankan Project

### 1. Clone Repository

```bash
git clone https://github.com/Rizkywhyws/Noctura-Mobile.git
cd Noctura-Mobile
```

### 2. Install Dependency Flutter

```bash
flutter pub get
```

### 3. Konfigurasi Base URL API

Sesuaikan base URL API pada file konfigurasi di `lib/config/` agar mengarah ke server backend Laravel yang sedang berjalan.

Contoh konfigurasi:

```dart
const String baseUrl = 'http://10.0.2.2:8000/api'; // Untuk Android Emulator
// const String baseUrl = 'http://localhost:8000/api'; // Untuk iOS Simulator
// const String baseUrl = 'http://:8000/api';  // Untuk perangkat fisik
```

### 4. Pastikan Backend Sudah Berjalan

Pastikan server Laravel (Noctura Web Admin) sudah berjalan sebelum menjalankan aplikasi mobile.

```bash
# Di repository Noctura-Web
php artisan serve
```

### 5. Jalankan Aplikasi

```bash
flutter run
```

Atau pilih target device secara eksplisit:

```bash
flutter run -d 
```

Untuk melihat daftar device yang tersedia:

```bash
flutter devices
```

### 6. Build APK (Opsional)

```bash
flutter build apk --release
```

File APK akan tersedia di:

```
build/app/outputs/flutter-apk/app-release.apk
```

## Environment & Konfigurasi

Seluruh konfigurasi seperti base URL API, API key, dan pengaturan lainnya diatur pada file di direktori `lib/config/`.

Pastikan untuk tidak mengunggah konfigurasi yang berisi data sensitif ke GitHub.

## Catatan Penggunaan

- Pastikan backend Laravel sudah berjalan sebelum menjalankan aplikasi.
- Untuk Android Emulator, gunakan `10.0.2.2` sebagai pengganti `localhost`.
- Untuk perangkat fisik, gunakan IP LAN dari komputer yang menjalankan backend.
- Pastikan Flutter SDK sudah dikonfigurasi dengan benar menggunakan `flutter doctor`.
- Jalankan `flutter pub get` setiap kali ada perubahan pada `pubspec.yaml`.

## Halaman Aplikasi

Beberapa halaman utama pada aplikasi mobile:

- Login
- Register
- Dashboard
- Prediksi Gangguan Tidur
- Riwayat Prediksi
- Visualisasi Data
- Sleep Log
- Edukasi
- Chatbot
- Profil

## Relasi dengan Noctura Web Admin

Aplikasi mobile ini terintegrasi dengan [Noctura Web Admin](https://github.com/Doansnpr/Noctura-Web) melalui REST API. Data prediksi yang dikirimkan dari aplikasi mobile akan tersimpan di MongoDB dan dapat dipantau oleh admin melalui web dashboard.

## License

This project is distributed under the [MIT License](LICENSE).

## Copyright

Copyright (c) 2026 Sleep Well Team
