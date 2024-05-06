import 'package:flutter/material.dart';
import 'package:project_kucari/src/style.dart';
import 'package:project_kucari/widget/textfield/custom_textfield.dart';

class NewPass extends StatefulWidget {
  const NewPass({super.key});

  @override
  State<NewPass> createState() => _NewPassState();
}

class _NewPassState extends State<NewPass> {
  final passwordController = TextEditingController();
  final passwordforController = TextEditingController();
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: AppColors.putih,
        title: Text(
          'Buat Kata Sandi Baru',
          style: TextStyles.titlehome,
        ),
        // backgroundColor: AppColors.putih,
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
                Transform.scale(
                  scale: 0.8,
                  child: Image.asset(
                    'assets/img/newPass.png',
                  ),
                ),
                SizedBox(height: 16.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text(
                        'kata Sandi',
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
                    // Mengganti CustomTextField menjadi CostumTextField
                    controller: passwordController,
                    textInputType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.next,
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

                SizedBox(height: 16.0),
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
                    // Mengganti CustomTextField menjadi CostumTextField
                    controller: passwordforController,
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
                SizedBox(height: 60.0),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                        horizontal: 145.0,
                        vertical: 16.0), // Sesuaikan dengan kebutuhan
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(8.0), // Tidak ada radius
                    ),
                    backgroundColor: AppColors.hijau,
                  ),
                  child: Text(
                    'LANJUT',
                    style: TextStyle(color: Colors.white).copyWith(
                      fontSize: 14.0,
                    ),
                  ),
                ),

                //  SizedBox(height: 30.0),
                //   ElevatedButton(
                //     onPressed: () {},
                //     style: ElevatedButton.styleFrom(
                //       padding: EdgeInsets.symmetric(horizontal: 130.0, vertical: 13.0), // Sesuaikan dengan kebutuhan
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(8.0), // Tidak ada radius
                //       ),
                //       backgroundColor: AppColors.hijau,
                //     ),
                //     child: Text(
                //       'LANJUT',
                //       style: TextStyle(color: Colors.white,
                //         fontSize: 14.0,
                //       ),
                //     ),
                //   ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
