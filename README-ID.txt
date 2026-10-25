PORTOFOLIO KREATIF — PANDUAN SINGKAT
=====================================

ISI ZIP
- index.html            Website portofolio
- admin.html            Panel admin
- style.css             Desain responsif
- app.js                Tampilan portofolio dan galeri
- admin.js              Login dan pengelolaan konten
- config.js             Konfigurasi Supabase
- supabase-setup.sql    SQL database + penyimpanan foto

PENTING
Website ini sengaja dibuat dengan konten awal yang kosong / placeholder. Agar perubahan dari admin tampil untuk semua pengunjung, sambungkan ke Supabase terlebih dahulu.

LANGKAH SETUP (HP ANDROID + GITHUB + VERCEL)
1. Ekstrak ZIP ini. Upload SEMUA FILE DI DALAM FOLDER ke root repository GitHub (jangan upload folder pembungkusnya).
2. Di Supabase, buka SQL Editor > New query. Salin isi supabase-setup.sql, lalu tekan Run.
3. Supabase > Project Settings > API: salin Project URL dan publishable key (atau anon public key lama).
4. Buka config.js dan ganti:
   https://YOUR-PROJECT.supabase.co
   PASTE_YOUR_SUPABASE_PUBLISHABLE_OR_ANON_KEY_HERE
   dengan nilai dari project Supabase milikmu.
5. Di Supabase > Authentication > Users, pilih Add user / Create new user. Buat email dan password admin yang kamu simpan sendiri.
6. Deploy repository di Vercel. Kalau sudah terhubung, setiap update file di GitHub akan ter-deploy otomatis.
7. Buka domain website kamu, lalu masuk ke /admin.html untuk login dan mengatur konten.

CATATAN KEAMANAN
- Jangan pernah menaruh service_role/secret key di config.js. Hanya gunakan publishable/anon public key.
- SQL memberi hak edit kepada user yang sudah login. Untuk website pribadi, jangan berikan akun admin kepada orang lain.
- Gunakan gambar berukuran wajar, maksimal 8 MB per gambar.
- Jika login gagal, cek URL dan public key di config.js, lalu pastikan user admin sudah dibuat di Supabase Authentication.
- Jika simpan gagal, pastikan SQL berhasil dijalankan dan user sudah login.
- Konten kosong tetap menampilkan placeholder. Setelah Supabase tersambung, semua perubahan yang disimpan dapat dibaca pengunjung lain.
