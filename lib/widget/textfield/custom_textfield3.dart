import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:project_kucari/src/style.dart';

class CustomTextField3 extends StatefulWidget {
  const CustomTextField3({
    required this.controller,
    required this.textInputType,
    required this.textInputAction,
    this.focusNode,
    Key? key,
  }) : super(key: key);

  final TextEditingController controller;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final FocusNode? focusNode;

  @override
  _CustomTextField3State createState() => _CustomTextField3State();
}

class _CustomTextField3State extends State<CustomTextField3> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: TextAlign.start,
      maxLines: null,
      keyboardType: TextInputType.multiline,
      controller: widget.controller,
      focusNode: widget.focusNode,
      textInputAction: TextInputAction.newline, // Mengubah TextInputAction
      cursorColor: AppColors.gray700,
      textAlignVertical: TextAlignVertical.top,
      textDirection: TextDirection.ltr,
      decoration: InputDecoration(
        contentPadding:
            EdgeInsets.only(bottom: 90, top: 10, right: 10, left: 10),
        filled: true,
        fillColor: AppColors.gray300,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.gray200,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1.0,
            color: AppColors.gray200,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
