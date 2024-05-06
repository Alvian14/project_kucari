import 'package:flutter/material.dart';
import 'package:project_kucari/page/beranda/home_screen.dart';
import 'package:project_kucari/page/beranda/notifikasi_screen.dart';
import 'package:project_kucari/page/beranda/profil_screen.dart';
import 'package:project_kucari/page/beranda/upload_screen.dart';
import 'package:project_kucari/src/style.dart'; 

class NavbarScreen extends StatefulWidget {
  final int userId;
  final Function(int) onTabPressed;
  int selectedIndex;

  NavbarScreen({Key? key, required this.userId, required this.onTabPressed, this.selectedIndex = 0}) : super(key: key);

  @override
  _NavbarScreenState createState() => _NavbarScreenState();

  static List<Widget> initWidgetOptions(int userId) {
    return [
      HomeScreen(userId: userId),
      UploadScreen(userId: userId),
      ProfilScreen(userId: userId),
    ];
  }
}


class _NavbarScreenState extends State<NavbarScreen> {
  late List<Widget> _widgetOptions;

  @override
  void initState() {
    super.initState();
    _widgetOptions = NavbarScreen.initWidgetOptions(widget.userId);
  }

  void _onItemTapped(int index) {
    setState(() {
      widget.selectedIndex = index;
    });
    widget.onTabPressed(index);
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    body: SafeArea(
      child: Center(
        child: _widgetOptions.elementAt(widget.selectedIndex),
      ),
    ),
    bottomNavigationBar: BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: ImageIcon(AssetImage('assets/icon/home.png')),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(AssetImage('assets/icon/upload.png')),
          label: 'Upload',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(AssetImage('assets/icon/user.png')),
          label: 'Profil',
        ),
      ],
      currentIndex: widget.selectedIndex,
      selectedItemColor: AppColors.hijau,
      unselectedItemColor: AppColors.gray100,
      iconSize: 20,
      onTap: _onItemTapped,
      showSelectedLabels: true,
      showUnselectedLabels: true,
    ),
  );
}
}