import 'dart:convert';

import 'package:d_method/d_method.dart';
import 'package:http/http.dart' as http;
import 'package:project_kucari/src/ApiService.dart';

Future<void> sendOtp(String email) async {
  var url = ApiService.urlApi('otp');
  var response = await http.post(
    url,
    body: {'email': email},
  );

  if (response.statusCode == 200) {
    DMethod.log('otp ');
    var otpData = jsonDecode(response.body);
    var otp = otpData['otp'];
    print('kode otp : $otp');
  } else {
    print('Gagal mengirim OTP: ${response.body}');
  }
}

void main() async{
  await sendOtp('kucariapps@gmail.com');

}