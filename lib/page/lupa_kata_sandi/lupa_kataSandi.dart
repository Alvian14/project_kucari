import 'dart:convert';

import 'package:d_method/d_method.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_kucari/page/lupa_kata_sandi/kodeOtp_screen.dart';
import 'package:project_kucari/src/ApiService.dart';
import 'package:project_kucari/src/style.dart';
import 'package:project_kucari/widget/message.dart';
import 'package:project_kucari/widget/textfield/custom_textfield.dart';
import 'package:http/http.dart' as http;

class LupaKataSandi extends StatefulWidget {
  @override
  _LupaKataSandi createState() => _LupaKataSandi();
}

class _LupaKataSandi extends State<LupaKataSandi> {
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: AppColors.putih,
        shadowColor: AppColors.hitam,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Kembali ke halaman sebelumnya
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 30.0),
                Image.asset(
                  'assets/img/lupaSandi.png',
                ),
                SizedBox(height: 16.0),
                Text(
                  'LUPA KATA SANDI',
                  style: TextStyles.body,
                ),
                SizedBox(height: 16.0),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Silakan masukkan Email yang telah terdaftar pada akun anda.',
                    style: TextStyles.hint,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 5.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text(
                        'Email',
                        style: TextStyles.title,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 3.0),
                Container(
                  constraints: const BoxConstraints(
                    maxWidth: 340.0,
                  ),
                  child: CustomTextField(
                    autofillHints: const [AutofillHints.email],
                    controller: emailController,
                    textInputType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.done,
                    prefixIcon: 'assets/img/email.png',
                    hint: '',
                  ),
                ),
                const SizedBox(height: 30.0),
                ElevatedButton(
                  onPressed: () async {
                    KucariMessage.showLoading();

                    var url = ApiService.urlApi('otp');
                    var response = await http.post(
                      url,
                      body: {'email': emailController.text},
                    );

                    Get.back();

                    if (response.statusCode == 200) {
                      DMethod.log('OTP body : ${response..body}');
                      var otpData = jsonDecode(response.body);
                      if (otpData['status'] == 'success') {
                         DMethod.log('OTP terkirim : ${response..body}');
                        var otp = otpData['otp'];
                        DMethod.log('kode otp: $otp');

                        Get.off(
                          OTPScreen(otp: otp, email: emailController.text,),
                          transition: Transition.rightToLeft,
                          duration: const Duration(milliseconds: 500),
                        );
                      } else {
                        Get.showSnackbar(
                          GetSnackBar(
                            title: 'Peringatan',
                            message:
                                otpData['message'] ?? 'Error tidak dikenal',
                            duration: Duration(seconds: 3),
                          ),
                        );
                      }
                    } else {
                      // Jika respons bukan 200, tampilkan kesalahan dari server atau pesan default
                      var errorData = jsonDecode(response.body);
                      Get.showSnackbar(
                        GetSnackBar(
                          title: 'Peringatan',
                          message: errorData['message'] ??
                              'Terjadi kesalahan pada server',
                          duration: Duration(seconds: 3),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 130.0,
                        vertical: 13.0), // Sesuaikan dengan kebutuhan
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(8.0), // Tidak ada radius
                    ),
                    backgroundColor: AppColors.hijau,
                  ),
                  child: Text(
                    'KONFIRMASI',
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
    );
  }
}
