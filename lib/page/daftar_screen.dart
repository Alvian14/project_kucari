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
  RegExp whatsAppValidator = RegExp(
    r'^[0-9]{10,15}$',
  );

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

  Future<void> registerUser() async {
    // Set focus to empty input fields before registering user
    if (namaController.text.trim().isEmpty) {
      showAlert(context, "Gagal", "Nama tidak boleh hanya spasi");
      FocusScope.of(context).requestFocus(_namaFocus);
      return;
    } else if (emailController.text.isEmpty) {
      FocusScope.of(context).requestFocus(_emailFocus);
      return;
    } else if (WhatsAppController.text.isEmpty) {
      FocusScope.of(context).requestFocus(_whatsAppFocus);
      return;
    } else if (passwordController.text.isEmpty) {
      FocusScope.of(context).requestFocus(_passwordFocus);
      return;
    } else if (passwordforController.text.isEmpty) {
      FocusScope.of(context).requestFocus(_passwordforFocus);
      return;
    } else if (passwordController.text != passwordforController.text) {
      showAlert(context, "Gagal", "Konfirmasi password tidak sesuai");
      return;
    } else if (!emailValidator.hasMatch(emailController.text)) {
      showAlert(context, "Gagal", "Format email tidak valid");
      return;
    } else if (!whatsAppValidator.hasMatch(WhatsAppController.text)) {
      showAlert(context, "Gagal", "Format nomor WhatsApp tidak valid");
      return;
    } 

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

      // Periksa apakah respons berhasil atau tidak
      if (response.statusCode == 200) {
        // Respons sukses
        final jsonResponse = jsonDecode(response.body); // Dekode JSON respons
        showAlert(context, "Berhasil", jsonResponse['message']);
        Future.delayed(Duration(seconds: 2), () {
          // Navigasi ke halaman login setelah menampilkan pesan berhasil
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    LoginScreen()), // Ganti LoginPage dengan halaman login Anda
          );
        });
      } else {
        // Respons gagal
        final errorMessage = jsonDecode(response.body)['message'] ??
            "Gagal mendaftarkan user"; // Ambil pesan error dari respons server, jika ada
        showAlert(context, "Gagal", errorMessage);
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
