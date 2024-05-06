import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_kucari/evi.dart';
import 'package:project_kucari/firebase_options.dart';
import 'package:project_kucari/page/beranda/profil_screen.dart';
// import 'package:project_kucari/page/login_screen.dart';
import 'package:project_kucari/page/splash_screen.dart';
import 'package:project_kucari/src/google.dart';
import 'package:provider/provider.dart'; // Adjust the package name accordingly

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GoogleSignService())
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
       
      ),
    );
  }
}

