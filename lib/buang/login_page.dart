// login_page.dart
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          // Gambar di atas
          Image.asset(
            'assets/img/login.png', // Ganti dengan path/logo Anda
            width: 250,
            height: 250,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 250), // Sesuaikan dengan tinggi gambar
                // Teks masuk di tengah
                Text(
                  'Masuk',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),

                // Kolom untuk memasukkan email
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                    ),
                  ),
                ),
                SizedBox(height: 8),

                // Kolom untuk memasukkan password
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                    ),
                  ),
                ),
                SizedBox(height: 16),

                // Tombol masuk
                ElevatedButton(
                  onPressed: () {
                    // Implementasi aksi yang diambil saat tombol ditekan
                  },
                  child: Text('Masuk'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
