import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_kucari/page/beranda/profil_screen.dart';
import 'package:project_kucari/src/ApiService.dart';
import 'package:project_kucari/src/navbar_screen.dart';
import 'package:project_kucari/src/style.dart';
import 'dart:convert';
import 'package:project_kucari/widget/textfield/custom_textfield.dart';

class UbahKataSandi extends StatefulWidget {
  final int userId;

  UbahKataSandi({Key? key, required this.userId}) : super(key: key);

  @override
  _UbahKataSandiState createState() => _UbahKataSandiState();
}

class _UbahKataSandiState extends State<UbahKataSandi> {
  final TextEditingController passwordOldController = TextEditingController();
  final TextEditingController passwordNewController = TextEditingController();
  final TextEditingController passwordForController = TextEditingController();
  bool isObscure = true;
  FocusNode _oldPassword = FocusNode();
  FocusNode _newPassword = FocusNode();
  FocusNode _confirm = FocusNode();

  @override
  void dispose() {
    _oldPassword.dispose();
    _newPassword.dispose();
    _confirm.dispose();
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

  Future<void> _updatePassword() async {
    if (passwordOldController.text.isEmpty) {
      FocusScope.of(context).requestFocus(_oldPassword);
      return;
    } else if (passwordNewController.text.isEmpty) {
      FocusScope.of(context).requestFocus(_newPassword);
      return;
    } else if (passwordForController.text.isEmpty) {
      FocusScope.of(context).requestFocus(_confirm);
      return;
    }

    if (passwordNewController.text != passwordForController.text) {
      showAlert(context, "Gagal", "Konfirmasi password tidak sesuai");
      return;
    }

    // if (passwordOldController.text) {
    //     showAlert(context, "Gagal", "Format email tidak valid");
    //     return;
    //   }

    try {
      final String apiUrl =
          ApiService.url('ubah_katasandi_profil.php').toString();

      final response = await http.post(
        Uri.parse(apiUrl),
        body: {
          'userId': widget.userId.toString(),
          'oldPassword': passwordOldController.text,
          'newPassword': passwordNewController.text,
        },
      );

      if (response.statusCode == 200) {
        // Respons sukses
        final jsonResponse = jsonDecode(response.body); // Dekode JSON respons
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Pesan"),
              content: Text(jsonResponse['message']),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Tutup dialog
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        // Respons gagal
        final errorMessage = jsonDecode(response.body)['message'] ??
            "Gagal mengubah kata sandi"; // Ambil pesan error dari respons server, jika ada
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Ubah Kata Sandi',
            style: TextStyles.titlehome,
          ),
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
                children: [
                  SizedBox(height: 50),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text(
                          'Kata Sandi Lama',
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
                      controller: passwordOldController,
                      textInputType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.next,
                      prefixIcon: 'assets/img/Lock.png',
                      hint: '',
                      focusNode: _oldPassword,
                      isObscure: isObscure,
                      hasSuffix: true,
                      onPressed: () {
                        setState(() {
                          isObscure = !isObscure;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text(
                          'Kata Sandi Baru',
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
                      controller: passwordNewController,
                      textInputType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.next,
                      prefixIcon: 'assets/img/Lock.png',
                      hint: '',
                      focusNode: _newPassword,
                      isObscure: isObscure,
                      hasSuffix: true,
                      onPressed: () {
                        setState(() {
                          isObscure = !isObscure;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text(
                          'Konfirmasi Kata Sandi Baru',
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
                      controller: passwordForController,
                      textInputType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                      prefixIcon: 'assets/img/Lock.png',
                      hint: '',
                      focusNode: _confirm,
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
                    onPressed: _updatePassword,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          horizontal: 100.0, vertical: 13.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      backgroundColor: AppColors.hijau,
                    ),
                    child: Text(
                      'UBAH',
                      style: TextStyle(color: Colors.white).copyWith(
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
