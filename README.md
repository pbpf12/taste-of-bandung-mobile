# Taste of Bandung

Aplikasi yang dikembangkan oleh kelompok 12 PBP F yang menghadirkan informasi seputar kuliner lokal Bandung.

## Anggota Kelompok

| Nama                   | NPM        | 
|------------------------|------------|
| Alexander William Lim  | 2306207505 |
| Figo Favian Ragazo     | 2306241764 |
| Rafie Asadel Tarigan   | 2306245485 |
| Rahardi Salim          | 2306201861 |
| Zillan Ahmad Ryandi    | 2306275443 |  

## Deskripsi Aplikasi

Pernahkah Anda merasa tersesat di tengah hiruk-pikuk jalanan Bandung, tanpa tahu ke mana harus pergi untuk menemukan pengalaman kuliner lokal yang autentik? Kini, Anda tidak perlu khawatir lagi. Kami hadir dengan solusi yang tepat untuk Anda—**Taste of Bandung**, sebuah platform yang dirancang khusus untuk menghadirkan informasi terkini, paling akurat, dan berperingkat tertinggi tentang kuliner lokal di sekitar Anda.

Taste of Bandung diciptakan dengan detail oleh tim ahli kami, menghadirkan antarmuka yang mudah dan intuitif, memastikan Anda bisa dengan cepat menemukan rekomendasi terbaik untuk memaksimalkan waktu Anda di Bandung. Baik Anda penduduk lokal maupun wisatawan, menjelajahi platform kami akan menjadi keputusan yang tidak Anda sesali. Dengan fitur unggulan seperti penandaan, penyaringan, dan rekomendasi yang dipersonalisasi, **Taste of Bandung** memberikan pengalaman yang menyenangkan dan efisien.

Ingin berbagi pengalaman kuliner Anda dengan komunitas? Kami juga menyediakan sistem ulasan, memungkinkan Anda untuk membagikan cerita dan kesan Anda selama menikmati kuliner di Bandung. Tunggu apa lagi? Segeralah bergabung dengan **Taste of Bandung** dan temukan dunia kuliner terbaik yang ditawarkan kota ini.

## Daftar Modul

| Nama Modul                | Penanggung Jawab | Deskripsi                                                                                                                                                 |
|---------------------------|--------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------|                                       
| **Authentication**            | _SEMUA_      | Membuat akun pengguna dan melakukan verifikasi informasi pengguna. Akses ke situs aplikasi hanya diberikan jika pengguna berhasil terotentikasi.|                                   
| **User Profile Screen**     | Alex         |Menampilkan informasi pengguna, seperti email, nama depan, dan nama belakang, serta riwayat kunjungan ke berbagai halaman detail produk.|
| **Home Screen**   | Zillan       | Halaman utama yang ditampilkan setelah pengguna berhasil login, menampilkan 3 produk kuliner teratas berdasarkan rating terbaru.|
| **Product Details**  | Salim        | Menyediakan informasi lengkap mengenai suatu produk kuliner. Pengguna dapat memberikan ulasan, melakukan vote atau downvote pada review, melihat informasi restoran terkait, dan menambahkan produk ke dalam bookmark.|
| **Search Screen**           | Rafie        | Halaman pencarian yang memungkinkan pengguna mencari produk berdasarkan filter seperti urutan harga (termurah hingga termahal), harga minimum dan maksimum, kategori (makanan, minuman, atau keduanya), dan nama kuliner.|
| **BookMarks Screen**   | Figo         | Menampilkan semua produk yang telah ditandai (bookmark) oleh pengguna, serta menyediakan opsi untuk menghapus produk dari bookmark.|

## Sumber Inisial Dataset
Sumber inisial dataset dapat dilihat dari :
- [Sumber Dataset](https://docs.google.com/spreadsheets/d/16gu9gPa8Nin2xFiqhyMezOKgs5oYMscOEMwLaojXCeM/edit?usp=sharing)
- [GoFood](https://gofood.co.id/)
- [Pergi Kuliner](https://pergikuliner.com/)
- [GrabFood](https://www.grab.com/id/food/)
- [BelahDoeren](https://belahdoeren.id/)
- [Kedai Nyonya Rumah](https://www.kedainyonyarumah.com/)
- [Instagram](https://www.instagram.com/)
- [Facebook](https://web.facebook.com/)

## Peran Pengguna

- **Pengguna**  
  Dapat mencari produk, menambahkan *bookmark*, meninggalkan ulasan, menyarankan produk baru, mengelola profil, dan menikmati fitur lainnya.

## Alur Integrasi dengan Web Service

Menggunakan domain **rahardi-salim-tasteofbandung.pbp.cs.ui.ac.id** serta proses penyimpanan cookies dan kredensial pengguna (username & password) di **local storage** dengan bantuan **pbp_django_auth**, berikut langkah-langkahnya:

### 1. Pengecekan Kredensial Pengguna
- Sistem akan memeriksa apakah pengguna sudah pernah login sebelumnya di file `lib/app_wrapper.dart`.  
- Jika sudah, pengguna akan langsung diarahkan ke halaman utama tanpa perlu login ulang.

### 2. Autentikasi Manual
- Jika pengguna belum pernah login, mereka akan diarahkan ke halaman login (`lib/features/authentication/screens/login.dart`) melalui path `'auth/login'`.
- Setelah berhasil login, kredensial pengguna dan cookies akan disimpan di **local storage**, yang akan digunakan untuk request selanjutnya.
- Jika pengguna belum memiliki akun, mereka dapat mengklik opsi "Register" untuk diarahkan ke halaman registrasi (`lib/features/authentication/screens/register.dart`) melalui path `'auth/register'`.

### 3. Operasi CRUD dengan Web Service
- Cookies dan pengiriman request akan secara otomatis ditangani oleh **pbp_django_auth**.
- Developer hanya perlu menyediakan:
  - **URL**: Endpoint yang akan diakses.
  - **Query**: Parameter tambahan (jika ada).
  - **Data**: Informasi yang akan dikirim bersama request.

### 4. Menghapus Kredensial Pengguna
- Logout dilakukan melalui path `'auth/logout'`, yang akan:
  - Menghapus cookies.
  - Menghapus kredensial pengguna dari **local storage**.
  - Mengarahkan pengguna kembali ke halaman login.

Dengan alur ini, integrasi menjadi lebih efisien dan mempermudah pengelolaan autentikasi serta operasi pada modul web service.
