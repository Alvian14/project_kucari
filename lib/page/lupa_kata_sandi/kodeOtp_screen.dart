import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_kucari/page/lupa_kata_sandi/lupaSandi_konfirmasi.dart';
import 'package:project_kucari/src/style.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({
    Key? key,
    required this.otp,
    required this.email,
  }) : super(key: key);

  final String otp;
  final String email;

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final passwordController = TextEditingController();
  final passwordforController = TextEditingController();
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    String otpInput = '';
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Lupa Kata Sandi',
          style: TextStyles.body,
        ),
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
                SizedBox(height: 140),
                Text(
                  'Kode telah dikirim ke Email Anda',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                  ),
                ),
                SizedBox(height: 40),
                OtpTextField(
                  numberOfFields: 4,
                  borderRadius: BorderRadius.circular(8),
                  borderColor: AppColors.gray200,
                  showFieldAsBox: true,
                  onCodeChanged: (String code) {
                    //handle validation or checks here
                  },
                  onSubmit: (String verificationCode) {
                    otpInput = verificationCode;
                  },
                ),
                const SizedBox(height: 20),
                // Text(
                //   'Kirim ulang kode dalam',
                //   textAlign: TextAlign.center,
                //   style: TextStyle(
                //     color: Colors.black,
                //     fontSize: 17,
                //   ),
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Text(
                //       '53',
                //       style: TextStyle(
                //         color: Colors.red,
                //         fontSize: 17,
                //       ),
                //     ),
                //     Text(
                //       ' detik',
                //       style: TextStyle(
                //         color: Colors.black,
                //         fontSize: 17,
                //       ),
                //     ),
                //   ],
                // ),
                SizedBox(height: 250),
                ElevatedButton(
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => NewPass()),
                    // );

                    if (widget.otp == otpInput) {
                      Get.to(NewPass(email: widget.email,));
                    }else{
                      Get.showSnackbar(
                        const GetSnackBar(
                          title: 'Peringatan',
                          message: 'Kode OTP tidak cocok',
                          duration: Duration(seconds: 4),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding:
                        EdgeInsets.symmetric(horizontal: 145.0, vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    backgroundColor: AppColors.hijau,
                  ),
                  child: Text(
                    'VERIFIKASI',
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
