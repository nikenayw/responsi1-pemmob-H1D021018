import 'package:flutter/material.dart';
import 'register_screen.dart'; // Pastikan ini diimpor

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Login'),
          backgroundColor: const Color.fromARGB(
              255, 232, 173, 85) // Ubah warna AppBar menjadi oranye
          ),
      body: Container(
        color: Colors.yellow[50], // Warna latar belakang kuning pastel
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Selamat Datang di Aplikasi Manajemen Keuangan',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 30), // Spasi antara judul dan form
                TextField(
                  decoration: InputDecoration(labelText: 'Email'),
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Tambahkan logika login di sini
                  },
                  child: Text('Login'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(
                        255, 232, 173, 85), // Ubah warna tombol menjadi oranye
                  ),
                ),
                SizedBox(
                    height: 20), // Spasi antara tombol login dan registrasi
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              RegisterScreen()), // Navigasi ke halaman registrasi
                    );
                  },
                  child: Text('Belum punya akun? Daftar di sini'),
                  style: TextButton.styleFrom(
                    backgroundColor: const Color.fromARGB(
                        255, 232, 173, 85), // Ubah warna teks menjadi oranye
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
