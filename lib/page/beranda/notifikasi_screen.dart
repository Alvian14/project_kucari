import 'package:flutter/material.dart';
import 'package:project_kucari/src/style.dart';

class NotifScreen extends StatefulWidget {
  const NotifScreen({super.key});

  @override
  State<NotifScreen> createState() => _NotifScreenState();
}

class _NotifScreenState extends State<NotifScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          elevation: 3,
          surfaceTintColor: AppColors.putih,
          shadowColor: AppColors.hitam,
          title: Text(
            'NOTIFIKASI',
            style: TextStyles.titlehome,
          ),
        ),
        body: ListView.builder(
          itemCount: notifikasiList.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(notifikasiList[index].fotoProfil),
              ),
              title: Text(notifikasiList[index].namaPengguna),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(notifikasiList[index].deskripsi),
                  Text(
                    '${notifikasiList[index].jam} • ${notifikasiList[index].tanggal}',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
              trailing: PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'delete') {
                    setState(() {
                      notifikasiList.removeAt(index);
                    });
                  }
                },
                child: Icon(Icons.more_vert, size: 20),  // Icon untuk memicu menu pop-up
                itemBuilder: (context) => [
                  PopupMenuItem<String>(
                    value: 'delete',
                    child: SizedBox(
                      width: 60, // Atur lebar sesuai kebutuhan
                      height: 30, // Atur tinggi sesuai kebutuhan
                      child: Center(
                        child: Text(
                          'Hapus',
                          style: TextStyle(fontSize: 14), // Sesuaikan ukuran teks sesuai kebutuhan
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}





class Notifikasi {
  final String fotoProfil;
  final String namaPengguna;
  final String deskripsi;
  final String jam;
  final String tanggal;

  Notifikasi({
    required this.fotoProfil,
    required this.namaPengguna,
    required this.deskripsi,
    required this.jam,
    required this.tanggal,
  });
}

// Dummy data notifikasi, sesuaikan dengan struktur data sebenarnya
List<Notifikasi> notifikasiList = [
  Notifikasi(
    fotoProfil: 'assets/img/Lock.ppg',
    namaPengguna: 'Tiyaaa',
    deskripsi: 'Postingan anda dikomentari!',
    jam: '15:30',
    tanggal: '08 Februari 2024',
  ),
  Notifikasi(
    fotoProfil: 'assets/foto_profil/user2.jpg',
    namaPengguna: 'Tiyaaa',
    deskripsi: 'Terima kasih atas kontribusinya!',
    jam: '09:45',
    tanggal: '07 Februari 2024',
  ),
  // ... tambahkan notifikasi lainnya sesuai kebutuhan
];



// Future<void> _konfirmasiHapus(BuildContext context, int index) async {
//   return showDialog<void>(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text('Konfirmasi'),
//         content: Text('Apakah Anda yakin ingin menghapus notifikasi ini?'),
//         actions: <Widget>[
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             child: Text('Tidak'),
//           ),
//           TextButton(
//             onPressed: () {
//               setState(() {
//                 notifikasiList.removeAt(index);
//               });
//               Navigator.of(context).pop();
//             },
//             child: Text('Ya'),
//           ),
//         ],
//       );
//     },
//   );
// }