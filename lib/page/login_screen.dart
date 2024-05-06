import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_kucari/page/daftar_screen.dart';
import 'package:project_kucari/page/lupa_kata_sandi/lupa_kataSandi.dart';
import 'package:project_kucari/src/ApiService.dart';
import 'package:project_kucari/src/google.dart';
import 'package:project_kucari/src/navbar_screen.dart';
import 'package:project_kucari/src/style.dart';
import 'package:project_kucari/widget/textfield/custom_textfield.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isObscure = true;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FocusNode _emailFocus = FocusNode();
  FocusNode _passwordFocus = FocusNode();

  @override
  void dispose() {
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    // Setel fokus sebelum memvalidasi formulir
    if (emailController.text.isEmpty) {
      FocusScope.of(context).requestFocus(_emailFocus);
      return;
    } else if (passwordController.text.isEmpty) {
      FocusScope.of(context).requestFocus(_passwordFocus);
      return;
    }

    if (_formKey.currentState!.validate()) {
      final String email = emailController.text.trim();
      final String password = passwordController.text.trim();

      // **API Call with Error Handling**
      try {
        final String apiUrl = ApiService.url('login.php').toString();
        final response = await http.post(
          Uri.parse(apiUrl),
          body: jsonEncode({
            'email': email,
            'password': password,
          }),
        );

        final responseData = jsonDecode(response.body);

        if (responseData['status'] == 'success') {
          // Jika login berhasil, simpan userId dan pindahkan ke NavbarScreen
          int userId = responseData['userId']; // Misalnya, userId dikirimkan dari respons login
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => NavbarScreen(
                userId: userId,
                onTabPressed: (index) {},
              ),
            ),
          );
        } else {
          final errorMessage = responseData[
            'message'] ??
              'Gagal Masuk.'; 
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Gagal Masuk'),
              content: Text(errorMessage),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('OK'),
                ),
              ],
            ),
          );
        }
      } on Exception catch (e) {
        print('Login error: $e');
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Gagal Masuk'),
            content: Text('Email atau Password anda salah.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }


  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 55.0),
                  Image.asset(
                    'assets/img/login.png',
                    width: 230.0,
                    height: 230.0,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height: 12.0),
                  Text(
                    'MASUK',
                    style: TextStyles.body,
                  ),
                  SizedBox(height: 5.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text(
                          'E-mail',
                          style: TextStyles.title,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 3.0),
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: 340.0,
                    ),
                    child: CustomTextField(
                      controller: emailController,
                      focusNode: _emailFocus,
                      textInputType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      prefixIcon: 'assets/img/email.png',
                      hint: '',
                     
                    ),
                  ),
                  SizedBox(height: 12.0),
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
                  SizedBox(height: 3.0),
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: 340.0,
                    ),
                    child: CustomTextField(
                      controller: passwordController,
                      focusNode: _passwordFocus,
                      textInputType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                      prefixIcon: 'assets/img/Lock.png',
                      hint: '',
                      isObscure: isObscure,
                      hasSuffix: true,
                      onPressed: () {
                        setState(() {
                          isObscure = !isObscure;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 9.0),
                  Align(
                    alignment: FractionalOffset(0.92, 0.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LupaKataSandi()),
                        );
                      },
                      child: Text(
                        'Lupa Kata Sandi?',
                        style: TextStyles.tomato,
                      ),
                    ),
                  ),
                  SizedBox(height: 30.0),
                  ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          horizontal: 143.0, vertical: 12.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      backgroundColor: AppColors.hijau,
                    ),
                    child: Text(
                      'MASUK',
                      style: TextStyle(color: Colors.white).copyWith(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  SizedBox(height: 18.0),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: 100.0,
                      ),
                      child: _buildButtonLogin(),
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
                                      builder: (context) => HalamanDaftar()));
                            },
                            child: RichText(
                              text: TextSpan(
                                style: TextStyles.title,
                                children: [
                                  TextSpan(
                                    text: 'Belum punya akun? ',
                                  ),
                                  TextSpan(
                                    text: 'Daftar',
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
      ),
    );
  }

  _buildButtonLogin() {
    return Consumer<GoogleSignService>(
      builder: (context, google, child) {
        return ElevatedButton(
          onPressed: ()async {
            await google.googleLogin();

            ///
            
            //
            
          },
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 11.0, horizontal: 83.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            primary: Colors.white,
            side: BorderSide(
              color: AppColors.gray200,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/img/search.png',
                width: 24.0,
                height: 24.0,
              ),
              SizedBox(width: 8.0),
              Text(
                'Masuk dengan Google',
                style: TextStyle(color: Colors.black).copyWith(
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
