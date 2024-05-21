import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:project_kucari/page/login_screen.dart';
import 'package:project_kucari/src/ApiService.dart';
import 'package:project_kucari/src/style.dart';
import 'package:project_kucari/widget/textfield/custom_textfield.dart';
import 'package:http/http.dart' as http;

class HalamanDaftar extends StatefulWidget {
  @override
  _HalamanDaftarState createState() => _HalamanDaftarState();
}

class _HalamanDaftarState extends State<HalamanDaftar> {
  final namaController = TextEditingController();
  final emailController = TextEditingController();
  final WhatsAppController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordforController = TextEditingController();
  bool isObscure = true;
  FocusNode _namaFocus = FocusNode();
  FocusNode _emailFocus = FocusNode();
  FocusNode _whatsAppFocus = FocusNode();
  FocusNode _passwordFocus = FocusNode();
  FocusNode _passwordforFocus = FocusNode();

  RegExp emailValidator = RegExp(
    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
  );

  // Pola validasi untuk nomor WhatsApp
  RegExp whatsAppValidator = RegExp(r'^08[0-9]{9,11}$');

  @override
  void dispose() {
    _namaFocus.dispose();
    _emailFocus.dispose();
    _whatsAppFocus.dispose();
    _passwordFocus.dispose();
    _passwordforFocus.dispose();
    super.dispose();
  }

  Future<void> showAlert(
      BuildContext context, String title, String content) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
        );
      },
    );

    // Tunggu 2 detik
    await Future.delayed(Duration(seconds: 1));

    // Tutup alert setelah 2 detik
    Navigator.of(context).pop();
  }

  // kode validasi validasi
  Future<void> registerUser() async {
    if (namaController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Nama tidak boleh hanya spasi"),
          backgroundColor:
              Colors.red, // Set warna latar belakang merah untuk error
          duration: Duration(seconds: 2),
        ),
      );
      FocusScope.of(context).requestFocus(_namaFocus);
      return;
    } else if (emailController.text.isEmpty) {
      FocusScope.of(context).requestFocus(_emailFocus);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Email tidak boleh kosong"),
          backgroundColor:
              Colors.red, // Set warna latar belakang merah untuk error
          duration: Duration(seconds: 2),
        ),
      );
      return;
    } else if (WhatsAppController.text.isEmpty) {
      FocusScope.of(context).requestFocus(_whatsAppFocus);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Nomor WhatsApp tidak boleh kosong"),
          backgroundColor:
              Colors.red, // Set warna latar belakang merah untuk error
          duration: Duration(seconds: 2),
        ),
      );
      return;
    } else if (passwordController.text.isEmpty) {
      FocusScope.of(context).requestFocus(_passwordFocus);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Password tidak boleh kosong"),
          backgroundColor:
              Colors.red, // Set warna latar belakang merah untuk error
          duration: Duration(seconds: 2),
        ),
      );
      return;
    } else if (passwordforController.text.isEmpty) {
      FocusScope.of(context).requestFocus(_passwordforFocus);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Konfirmasi password tidak boleh kosong"),
          backgroundColor:
              Colors.red, // Set warna latar belakang merah untuk error
          duration: Duration(seconds: 2),
        ),
      );
      return;
    } else if (passwordforController.text.isEmpty ||
        passwordforController.text.length < 6 ||
        passwordforController.text.length > 8) {
      FocusScope.of(context).requestFocus(_passwordforFocus);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              "Password tidak boleh kosong. Panjang minimal 6 dan maksimal 8 karakter"),
          backgroundColor:
              Colors.red, // Set warna latar belakang merah untuk error
          duration: Duration(seconds: 2),
        ),
      );
      return;
    } else if (passwordController.text != passwordforController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Konfirmasi password tidak sesuai"),
          backgroundColor:
              Colors.red, // Set warna latar belakang merah untuk error
          duration: Duration(seconds: 2),
        ),
      );
      return;
    } else if (!emailValidator.hasMatch(emailController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Format email tidak valid"),
          backgroundColor:
              Colors.red, // Set warna latar belakang merah untuk error
          duration: Duration(seconds: 2),
        ),
      );
      return;
    } else if (!whatsAppValidator.hasMatch(WhatsAppController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Format nomor WhatsApp tidak valid"),
          backgroundColor:
              Colors.red, // Set warna latar belakang merah untuk error
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    // kode untuk check apakah email sudah terdaftar
    final response = await http.post(
      ApiService.url('check_email.php'), // Replace with your endpoint
      body: {'email': emailController.text},
    );

    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body);
      if (responseJson['success']) {
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Email sudah terdaftar"),
            backgroundColor:
                Colors.red, // Set warna latar belakang merah untuk error
            duration: Duration(seconds: 2),
          ),
        );
        return;
      }
    } else {
      // Handle server error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Terjadi kesalahan pada server'),
          backgroundColor: Colors.red,
        ),
      );
    }

    // kode untuk register
    try {
      final String apiUrl = ApiService.url('register.php').toString();

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          "nama_user": namaController.text,
          "email": emailController.text,
          "no_wa": WhatsAppController.text,
          "password": passwordController.text,
          "confirmPassword": passwordforController.text,
        }),
      );

      if (response.statusCode == 200) {
        // Respons sukses
        final jsonResponse = jsonDecode(response.body); // Dekode JSON respons
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(jsonResponse['message']),
            backgroundColor: Colors.green, // Tampilkan pesan di snackbar
            duration: Duration(seconds: 2), // Durasi snackbar tampil
          ),
        );

        Future.delayed(Duration(seconds: 2), () {
          // Navigasi ke halaman login setelah menampilkan pesan berhasil
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  LoginScreen(), // Ganti LoginPage dengan halaman login Anda
            ),
          );
        });
      } else {
        // Respons gagal
        final errorMessage = jsonDecode(response.body)['message'] ??
            "Gagal mendaftarkan user"; // Ambil pesan error dari respons server, jika ada
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage), // Tampilkan pesan error di snackbar
            backgroundColor: AppColors.tomato,
            duration: Duration(seconds: 5), // Durasi snackbar tampil
          ),
        );
      }
    } catch (e) {
      // Tangani kesalahan jaringan atau lainnya
      print('Error: $e');
      showAlert(
          context, "Error", "Terjadi kesalahan. Silakan coba lagi nanti.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: AppColors.putih,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  'DAFTAR',
                  style: TextStyles.body,
                ),
                SizedBox(height: 30.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text(
                        'Nama',
                        style: TextStyles.title,
                      ),
                    ),
                    // Tambahkan widget lainnya di sini jika diperlukan
                  ],
                ),
                SizedBox(height: 8.0),
                Container(
                  constraints: BoxConstraints(
                    maxWidth: 340.0,
                  ),
                  child: CustomTextField(
                    controller: namaController,
                    textInputType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    prefixIcon: 'assets/img/Profile.png',
                    hint: '',
                    focusNode: _namaFocus,
                    maxLength: 30,
                  ),
                ),
                // SizedBox(height: ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text(
                        'Email',
                        style: TextStyles.title,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.0),
                Container(
                  constraints: BoxConstraints(
                    maxWidth: 340.0,
                  ),
                  child: CustomTextField(
                    controller: emailController,
                    textInputType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    prefixIcon: 'assets/img/email.png',
                    hint: '',
                    focusNode: _emailFocus,
                  ),
                ),
                SizedBox(height: 22),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text(
                        'WhatsApp',
                        style: TextStyles.title,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.0),
                Container(
                  constraints: BoxConstraints(
                    maxWidth: 340.0,
                  ),
                  child: CustomTextField(
                    controller: WhatsAppController,
                    textInputType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    prefixIcon: 'assets/img/whatsapp.png',
                    hint: '',
                    focusNode: _whatsAppFocus,
                    maxLength: 13,
                  ),
                ),
                // SizedBox(height: 3),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text(
                        'Kata Sandi',
                        style: TextStyles.title,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.0),
                Container(
                  constraints: BoxConstraints(
                    maxWidth: 340.0,
                  ),
                  child: CustomTextField(
                    controller: passwordController,
                    textInputType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.next,
                    prefixIcon: 'assets/img/Lock.png',
                    hint: '',
                    maxLength: 8,
                    isObscure: isObscure,
                    hasSuffix: true,
                    focusNode: _passwordFocus,
                    onPressed: () {
                      setState(() {
                        isObscure = !isObscure;
                      });
                    },
                  ),
                ),
                SizedBox(height: 3),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text(
                        'Konfirmasi Kata Sandi',
                        style: TextStyles.title,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.0),
                Container(
                  constraints: BoxConstraints(
                    maxWidth: 340.0,
                  ),
                  child: CustomTextField(
                    controller: passwordforController,
                    textInputType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                    prefixIcon: 'assets/img/Lock.png',
                    hint: '',
                    focusNode: _passwordforFocus,
                    maxLength: 8,
                    isObscure: isObscure,
                    hasSuffix: true,
                    onPressed: () {
                      setState(() {
                        isObscure = !isObscure;
                      });
                    },
                  ),
                ),
                SizedBox(height: 30.0),
                ElevatedButton(
                  onPressed: () {
                    registerUser();
                  },
                  style: ElevatedButton.styleFrom(
                    padding:
                        EdgeInsets.symmetric(horizontal: 145.0, vertical: 13.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    backgroundColor: AppColors.hijau,
                  ),
                  child: Text(
                    'DAFTAR',
                    style: TextStyle(color: Colors.white).copyWith(
                      fontSize: 14.0,
                    ),
                  ),
                ),
                SizedBox(height: 50.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                          },
                          child: RichText(
                            text: TextSpan(
                              style: TextStyles.title,
                              children: [
                                TextSpan(
                                  text: 'Sudah punya akun? ',
                                ),
                                TextSpan(
                                  text: 'Masuk',
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
