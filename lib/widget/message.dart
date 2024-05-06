import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KucariMessage{
  static void showLoading(){
    Get.dialog(
      const PopScope(
        canPop: true,
        child: Center(
          child: CircularProgressIndicator(
            color: Colors.pink,
          ),
        ),
      ),
      barrierDismissible: true,
      transitionCurve: Curves.easeOut,
    );
  }
}