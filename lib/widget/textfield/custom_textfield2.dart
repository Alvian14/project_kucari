import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:project_kucari/src/style.dart';

class CustomTextField2 extends StatefulWidget {
  const CustomTextField2({
    required this.controller,
    required this.textInputType,
    required this.textInputAction,
    this.enableDropdown = true,
    this.dropdownItems,
    this.focusNode,
    Key? key,
  }) : super(key: key);

  final TextEditingController controller;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final bool enableDropdown;
  final List<String>? dropdownItems;
  final FocusNode? focusNode;

  @override
  _CustomTextField2State createState() => _CustomTextField2State();
}

class _CustomTextField2State extends State<CustomTextField2> {
  String selectedItem = '';

  bool get _isDropdownEnabled =>
      widget.enableDropdown && widget.dropdownItems != null;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      keyboardType: TextInputType.multiline,
      focusNode: widget.focusNode,
      textInputAction: TextInputAction.newline,
      cursorColor: AppColors.gray700,
      readOnly:
          _isDropdownEnabled, // Set readOnly menjadi true jika dropdown diaktifkan
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
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
        suffixIcon: _isDropdownEnabled
            ? IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: () {
                  _showDropdownMenu(context);
                },
              )
            : null,
      ),
    );
  }

  // start dropdown
  void _showDropdownMenu(BuildContext context) async {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final RenderBox overlay =
        Overlay.of(context)!.context.findRenderObject() as RenderBox;
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(button.size.bottomRight(Offset.zero),
            ancestor: overlay),
        button.localToGlobal(button.size.bottomRight(Offset.zero),
            ancestor: overlay) + Offset(0, 0),
      ),
      Offset.zero & overlay.size,
    );

    final result = await showMenu(
      context: context,
      position: position,
      items: widget.dropdownItems!.map((item) {
        return PopupMenuItem<String>(
          value: item,
          child: SizedBox(
            height: 30, // Atur tinggi item dropdown
            child: Center(child: Text(item)),
          ),
        );
      }).toList(),
    );
    
    if (result != null) {
      setState(() {
        selectedItem = result;
        widget.controller.text = selectedItem;
      });
    }
  }
  // end dropdown
}
