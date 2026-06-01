# Sleep Disorder Prediction App

Sleep Disorder Prediction App adalah aplikasi mobile berbasis Machine Learning yang digunakan untuk melakukan prediksi dini terhadap potensi gangguan tidur berdasarkan data kesehatan dan gaya hidup pengguna.

Aplikasi ini mengimplementasikan algoritma Gradient Boosting (XGBoost) untuk melakukan klasifikasi kondisi tidur pengguna. Sistem terdiri dari aplikasi Flutter sebagai frontend, Flask API sebagai backend machine learning, serta model yang telah dilatih dan disimpan dalam format `.pkl`.

## Tim Pengembang

| Nama | NIM / Kelas | Role | GitHub |
|--------|------------|--------|---------|
| Nama Anda | XXXXXXXX | Fullstack Developer & Machine Learning Engineer | @username |

---

# Deskripsi Project

Sleep Disorder Prediction App merupakan sistem prediksi gangguan tidur yang dirancang untuk membantu pengguna mengetahui kemungkinan kondisi tidur mereka berdasarkan beberapa parameter kesehatan dan kebiasaan hidup.

Data yang dimasukkan pengguna akan dikirim melalui aplikasi Flutter menuju Flask API. Selanjutnya sistem akan memproses data menggunakan model Machine Learning yang telah dilatih menggunakan algoritma XGBoost. Hasil prediksi kemudian dikirim kembali ke aplikasi dan ditampilkan kepada pengguna secara real-time.

Project ini menggabungkan teknologi Mobile Development, Backend API, dan Machine Learning dalam satu alur sistem yang terintegrasi.

---

# Gambaran Umum Sistem

Berikut merupakan arsitektur umum sistem Sleep Disorder Prediction App.

![Overall Architecture](assets/overall-architecture.png)

## Alur Sistem

1. Dataset dikumpulkan dan digunakan sebagai data pelatihan.
2. Data dilakukan preprocessing untuk membersihkan dan menyesuaikan format data.
3. Model dilatih menggunakan algoritma Gradient Boosting (XGBoost).
4. Hasil model dievaluasi untuk mengetahui performa klasifikasi.
5. Model terbaik disimpan dalam format `.pkl`.
6. Flask API memuat model yang telah disimpan.
7. Flutter mengirimkan data input pengguna ke API.
8. API memproses data menggunakan model Machine Learning.
9. Sistem menghasilkan prediksi gangguan tidur.
10. Hasil prediksi dikirim kembali ke Flutter.
11. Flutter menampilkan hasil prediksi kepada pengguna.

---

# Fitur Utama

## 1. Prediksi Gangguan Tidur

Pengguna dapat memasukkan data kesehatan dan gaya hidup yang diperlukan untuk memperoleh hasil prediksi kondisi tidur.

## 2. Integrasi Machine Learning

Sistem menggunakan model XGBoost yang telah dilatih untuk melakukan klasifikasi gangguan tidur secara otomatis.

## 3. Flask REST API

Model Machine Learning diintegrasikan melalui Flask API sehingga dapat diakses oleh aplikasi mobile.

## 4. Mobile Application

Aplikasi Flutter digunakan sebagai antarmuka utama pengguna untuk melakukan prediksi dan melihat hasil analisis.

## 5. Real-Time Prediction

Hasil prediksi dapat diperoleh secara langsung setelah data dikirimkan ke server.

---

# Tech Stack

| Bagian | Teknologi |
|----------|------------|
| Mobile App | Flutter |
| Backend API | Flask |
| Machine Learning | XGBoost |
| Programming Language | Python |
| Data Processing | Pandas, NumPy |
| Model Serialization | Pickle (.pkl) |
| ML Library | Scikit-Learn |
| Gradient Boosting Library | XGBoost |

---

# Machine Learning Workflow

Dataset yang digunakan akan melalui beberapa tahapan sebelum digunakan untuk prediksi.

## Data Processing

Tahapan preprocessing meliputi:

- Data Cleaning
- Handling Missing Value
- Encoding Data Kategorikal
- Feature Selection
- Data Splitting (Training dan Testing)

## Training Model

Model dilatih menggunakan algoritma XGBoost karena:

- Memiliki performa tinggi pada data tabular
- Mampu menangani hubungan non-linear
- Memiliki regularization untuk mengurangi overfitting
- Efisien dalam proses training dan inference

## Evaluasi Model

Model dievaluasi menggunakan beberapa metrik klasifikasi seperti:

- Accuracy
- Precision
- Recall
- F1-Score
- Confusion Matrix

## Deployment Model

Setelah model memperoleh performa terbaik:

- Model disimpan dalam format `.pkl`
- Flask API akan melakukan load model saat server dijalankan
- Model siap menerima data baru dari aplikasi Flutter

---

# Struktur Project

```bash
Sleep-Disorder-Prediction/
│
├── Flask_API/
│   ├── app.py
│   ├── model.pkl
│   ├── requirements.txt
│   └── dataset/
│
├── Flutter/
│   ├── lib/
│   ├── assets/
│   └── pubspec.yaml
│
├── Model/
│   ├── training.ipynb
│   ├── preprocessing.ipynb
│   └── evaluation.ipynb
│
├── assets/
│   └── overall-architecture.png
│
└── README.md
```

---

# Prasyarat Sistem

Pastikan perangkat telah memiliki software berikut:

- Git
- Python 3.9+
- Flutter SDK
- Android Studio
- VS Code (Opsional)
- Pip

---

# Cara Instalasi dan Menjalankan Project

## 1. Clone Repository

```bash
git clone https://github.com/Rizkywhyws/e-learning.git
cd e-learning
```

---

## 2. Setup Flask API

Masuk ke folder backend:

```bash
cd Flask_API
```

Buat virtual environment:

```bash
python -m venv venv
```

Aktifkan virtual environment.

Windows:

```bash
venv\Scripts\activate
```

Linux / Mac:

```bash
source venv/bin/activate
```

Install dependency:

```bash
pip install -r requirements.txt
```

Jalankan server Flask:

```bash
python app.py
```

Server akan berjalan pada:

```bash
http://localhost:5000
```

---

## 3. Setup Flutter

Masuk ke folder Flutter:

```bash
cd Flutter
```

Install dependency:

```bash
flutter pub get
```

Sesuaikan Base URL API pada file konfigurasi.

Contoh:

```dart
static const String baseUrl = "http://192.168.1.x:5000";
```

Jalankan aplikasi:

```bash
flutter run
```

---

# Endpoint API

## Predict Sleep Disorder

### Request

```http
POST /predict
```

### Body JSON

```json
{
  "age": 25,
  "sleep_duration": 6,
  "stress_level": 8,
  "physical_activity": 30
}
```

### Response

```json
{
  "prediction": "Insomnia"
}
```

---

# Environment Variable

Apabila menggunakan file `.env`, konfigurasi dapat disesuaikan seperti berikut:

```env
FLASK_APP=app.py
FLASK_ENV=development
MODEL_PATH=model.pkl
```

---

# Hasil Prediksi

Sistem dapat menghasilkan klasifikasi seperti:

- Healthy Sleep
- Insomnia
- Sleep Apnea

Hasil prediksi ditampilkan langsung melalui aplikasi Flutter setelah proses inferensi selesai dilakukan oleh model.

---

# Arsitektur Integrasi

Flutter bertugas sebagai client application yang menerima input pengguna.

Flask API bertugas sebagai penghubung antara aplikasi dan model Machine Learning.

Model XGBoost melakukan proses inferensi berdasarkan data yang dikirimkan oleh pengguna.

Alur komunikasi:

```text
Flutter
   ↓
Flask API
   ↓
XGBoost Model (.pkl)
   ↓
Prediction Result
   ↓
Flutter UI
```

---

# Catatan Penggunaan

- Pastikan Flask API berjalan sebelum menjalankan aplikasi Flutter.
- Pastikan model `.pkl` tersedia pada direktori backend.
- Gunakan IP lokal komputer ketika menghubungkan Flutter dengan Flask API melalui emulator atau perangkat Android.
- Jangan menggunakan `localhost` pada perangkat fisik Android.

---

# License

This project is distributed under the MIT License.

---

# Copyright

Copyright (c) 2026 Sleep Disorder Prediction App Team
