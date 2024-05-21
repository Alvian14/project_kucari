import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_kucari/page/beranda/ubah_kataSandi.dart';
import 'package:project_kucari/page/beranda/ubah_profil.dart';
import 'package:project_kucari/page/login_screen.dart';
import 'package:project_kucari/src/ApiService.dart';
import 'package:project_kucari/src/style.dart';
import 'package:http/http.dart' as http;

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({Key? key, required this.userId});
  final int userId;

  @override
  _ProfilScreenState createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  late ImagePicker _imagePicker; // Declare image picker instance
  File? _imageFile; // Declare variable to store selected image file
  late String _username = '';
  late String _email = '';
  String? _imageUrl;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
    _fetchUserImage();
    _imagePicker = ImagePicker(); // Initialize image picker instance
  }

  // digunakan untuk memilih geleri atau kamera
  Future<void> _pickImage(ImageSource source) async {
    final XFile? selectedImage = await _imagePicker.pickImage(source: source);
    if (selectedImage != null) {
      setState(() {
        _imageFile = File(selectedImage.path);
      });
    }
  }

  // Diguanakn untuk upload gambar profil
  Future<void> _uploadImage() async {
    if (_imageFile == null) {
      // Tampilkan pesan bahwa gambar belum dipilih
      return;
    }
    final String apiUrl = ApiService.url('update_pp.php').toString();
    var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
    request.fields['userId'] = widget.userId.toString();

    if (_imageFile != null) {
      String fileName = _imageFile!.path.split('/').last;
      var image = await http.MultipartFile.fromPath('image', _imageFile!.path);
      request.files.add(image);
    }

    var streamedResponse = await request.send();

    if (streamedResponse.statusCode == 200) {
      print('Gambar berhasil diunggah');
    } else {
      print('Gagal mengunggah gambar: ${streamedResponse.reasonPhrase}');
    }
  }

  // Digunakan untuk mengambil data gambar
  Future<void> _fetchUserImage() async {
    final String apiUrl = ApiService.url('get_user_image.php').toString();
    final response =
        await http.get(Uri.parse('$apiUrl?userId=${widget.userId}'));
    if (response.statusCode == 200) {
      final imageData = json.decode(response.body);
      final fileName = imageData['fileName']; // Ini adalah URL lengkap gambar
      if (fileName != null && fileName.isNotEmpty) {
        setState(() {
          _imageUrl = fileName; // Menyimpan URL gambar
        });
      }
    } else {
      throw Exception('Failed to load user image');
    }
  }

  // diguanakn untuk mengambil data user
  Future<void> _fetchUserData() async {
    final String apiUrl = ApiService.url('user.php')
        .toString(); // Ganti 'user.php' dengan nama endpoint yang benar
    final response =
        await http.get(Uri.parse('$apiUrl?userId=${widget.userId}'));
    if (response.statusCode == 200) {
      final userData = json.decode(response.body);
      setState(() {
        _username = userData['username'];
        _email = userData['email'];
      });
    } else {
      throw Exception('Failed to load user data');
    }
  }

  // digunakan untuk pemilihan galeri atau kamera
  Future<dynamic> _showSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return SizedBox(
          height: 150,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FloatingActionButton(
                onPressed: () async {
                  // Pick image from camera and upload it
                  await _pickImage(ImageSource
                      .camera); // Await to ensure image is picked before uploading
                  await _uploadImage(); // Upload the picked image
                  Navigator.pop(context); // Close bottom sheet after upload
                },
                backgroundColor: Colors.black,
                heroTag: 'camera',
                child: const Icon(
                  Icons.camera_alt_outlined,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 15),
              FloatingActionButton(
                onPressed: () async {
                  // Pick image from gallery and upload it
                  await _pickImage(ImageSource
                      .gallery); // Await to ensure image is picked before uploading
                  await _uploadImage(); // Upload the picked image
                  Navigator.pop(context); // Close bottom sheet after upload
                },
                backgroundColor: Colors.purple,
                heroTag: 'gallery',
                child: const Icon(
                  Icons.image_outlined,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 15),
              _imageFile != null
                  ? FloatingActionButton(
                      onPressed: () async {
                        // Upload the image without picking from camera or gallery
                        await _uploadImage(); // Add await here
                        Navigator.pop(context, true); // Close bottom sheet after upload
                      },
                      backgroundColor: Colors.blueGrey,
                      heroTag: 'upload',
                      child: const Icon(
                        Icons.upload_outlined,
                        color: Colors.white,
                      ),
                    )
                  : const Material(),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'My Profile',
          style: TextStyles.titlehome,
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    // backgroundColor: AppColors.hij,
                    backgroundImage: _imageUrl != null
                        ? NetworkImage(_imageUrl!)
                        : AssetImage('assets/img/logoKucari.png')
                            as ImageProvider,
                  ),
                  Positioned(
                    top: 55,
                    left: 55,
                    child: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        _showSheet(context); // Call function to show bottom sheet
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                _username,
                style: TextStyles.textProfil,
              ),
              Text(
                _email, // Ganti dengan email
                style: TextStyles.hint,
              ),
        
              SizedBox(height: 50),
              Container(
                padding: EdgeInsets.only(left: 20, right: 20, bottom: 5),
                child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          UbahProfil(userId: widget.userId),
                    ),
                  );
                },
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'assets/icon/ballot.png', // Ganti dengan path gambar yang diinginkan
                              width: 25,
                              height: 25,
                            ),
                            SizedBox(width: 15),
                            Text(
                              'Ubah Profil',
                              style: TextStyles.hint,
                            ),
                          ],
                        ),
                        IconButton(
                          icon: Image.asset(
                            'assets/icon/next.png',
                            width: 20,
                            height: 20,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    UbahProfil(userId: widget.userId),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    Container(
                      height: 2,
                      color: AppColors.gray200,
                      margin: EdgeInsets.only(top: 5),
                    ),
                  ],
                ),
              ),
              ),
              //...
        
              SizedBox(height: 11),
              Container(
                padding: EdgeInsets.only(left: 20, right: 20, bottom: 5),
                child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          UbahKataSandi(userId: widget.userId),
                    ),
                  );
                },
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'assets/icon/ballot.png', // Ganti dengan path gambar yang diinginkan
                              width: 25,
                              height: 25,
                            ),
                            SizedBox(width: 15),
                            Text(
                              'Ubah Kata Sandi',
                              style: TextStyles.hint,
                            ),
                          ],
                        ),
                        IconButton(
                          icon: Image.asset(
                            'assets/icon/next.png',
                            width: 20,
                            height: 20,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    UbahKataSandi(userId: widget.userId),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    Container(
                      height: 2,
                      color: AppColors.gray200,
                      margin: EdgeInsets.only(top: 5),
                    ),
                  ],
                ),
              ),
              ),
              SizedBox(height: 250),
              GestureDetector(
                onTap: () {
                  showLogoutConfirmationDialog(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Keluar',
                      style: TextStyles.titlehome.copyWith(
                        color: AppColors.hijau,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void showLogoutConfirmationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Keluar"),
        content: Text("Apakah kamu yakin ingin keluar?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
            },
            child: Text(
              "Tidak",
               style: TextStyle(color: AppColors.tomato)
              ,
              // style,
            ),
          ),
          TextButton(
            onPressed: () {
              // Perform logout action here
              Navigator.pushReplacement(
                // Use pushReplacement to prevent going back to the previous screen
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
            child: Text("Iya",
             style: TextStyle(color: AppColors.hijau),
            ),
          ),
        ],
      );
    },
  );
}
