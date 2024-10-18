import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'login_screen.dart'; // Pastikan ini diimpor

class RegisterScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> registerUser(
      String email, String password, BuildContext context) async {
    final response = await http.post(
      Uri.parse('http://localhost:3000/register'), // Pastikan URL sesuai
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      // Pendaftaran berhasil
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Berhasil!',
                style: TextStyle(fontWeight: FontWeight.bold)),
            content: Text(
                'Akun Anda berhasil didaftarkan. Silahkan login untuk melanjutkan.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            LoginScreen()), // Navigasi ke halaman login
                  );
                },
              ),
            ],
          );
        },
      );
    } else {
      // Jika server tidak mengembalikan respons yang benar
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Gagal!'),
            content:
                Text('Terjadi kesalahan saat mendaftar. Silakan coba lagi.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftarkan Akun Kamu'),
        backgroundColor:
            const Color.fromARGB(255, 232, 173, 85), // Warna AppBar
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
                  'Registrasi Akun Kamu',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30), // Spasi antara judul dan form
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                ),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  child: Text('Register'),
                  onPressed: () async {
                    await registerUser(
                      emailController.text,
                      passwordController.text,
                      context, // Pass context ke registerUser
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color.fromARGB(255, 232, 173, 85), // Warna tombol
                  ),
                ),
                SizedBox(height: 20), // Spasi antara tombol dan text button
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              LoginScreen()), // Navigasi ke halaman login
                    );
                  },
                  child: Text('Sudah punya akun? Login di sini'),
                  style: TextButton.styleFrom(
                    backgroundColor:
                        const Color.fromARGB(255, 232, 173, 85), // Warna teks
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
