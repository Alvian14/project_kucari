import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_kucari/src/ApiService.dart';
import 'package:project_kucari/src/navbar_screen.dart';
import 'package:project_kucari/src/style.dart';
import 'package:project_kucari/widget/textfield/custom_textfield.dart';

class UbahProfil extends StatefulWidget {
  final int userId;

  UbahProfil({Key? key, required this.userId}) : super(key: key);

  @override
  _UbahProfilState createState() => _UbahProfilState();
}

class _UbahProfilState extends State<UbahProfil> {
  final namaController = TextEditingController();
  final emailController = TextEditingController();
  final whatsAppController = TextEditingController();
  late String _username = '';
  late String _email = '';
  late String _whatsapp = '';

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _updateProfile(BuildContext context) async {
    final String apiUrl = ApiService.url('ubah_profil.php').toString();

    final response = await http.post(
      Uri.parse(apiUrl),
      body: {
        'userId': widget.userId.toString(),
        'nama': namaController.text,
        'email': emailController.text,
        'whatsapp': whatsAppController.text,
      },
    );

    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Sukses'),
            content: Text('Profil berhasil diperbarui'),
            actions: [
              TextButton(
                onPressed: () {
                  // Pop the dialog first
                  Navigator.of(context).pop();
                  // Then navigate to the new screen
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NavbarScreen(
                        userId: widget.userId,
                        onTabPressed: (index) {
                          print('Tab $index selected');
                        },
                        selectedIndex: 2,
                      ),
                    ),
                  );
                },
                child: Text('OK',
                style: TextStyle(color: AppColors.hijau),
                ),
              ),
            ],
          );
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan. Silakan coba lagi')),
      );
    }
  }

  Future<void> _fetchUserData() async {
    final String apiUrl = ApiService.url('user.php').toString();

    final response =
        await http.get(Uri.parse('$apiUrl?userId=${widget.userId}'));

    if (response.statusCode == 200) {
      final userData = json.decode(response.body);
      setState(() {
        _username = userData['username'];
        _email = userData['email'];
        _whatsapp = userData['whatsapp'];
        namaController.text = _username;
        emailController.text = _email;
        whatsAppController.text = _whatsapp;
      });
    } else {
      throw Exception('Failed to load user data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Ubah Profil',
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
                  // Nama
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
                    ),
                  ),
                  SizedBox(height: 8),
                  // Email
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
                    ),
                  ),
                  SizedBox(height: 8),
                  // WhatsApp
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
                      controller: whatsAppController,
                      textInputType: TextInputType.phone,
                      textInputAction: TextInputAction.done,
                      prefixIcon: 'assets/img/whatsapp.png',
                      hint: '',
                    ),
                  ),
                  SizedBox(height: 30.0),
                  // Tombol Ubah
                  ElevatedButton(
                    onPressed: () {
                      _updateProfile(context);
                    },
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
                      style: TextStyle(color: Colors.white, fontSize: 14.0),
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
