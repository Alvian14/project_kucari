import 'package:flutter/material.dart';
import 'package:project_kucari/src/style.dart';

class Komentar extends StatefulWidget {
  const Komentar({Key? key}) : super(key: key);

  @override
  _KomentarState createState() => _KomentarState();
}

class _KomentarState extends State<Komentar> {
  List<String> balasan = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.white,
        elevation: 3,
        title: Text('Komentar'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: KomentarWidget(
        nama: 'Agus Fernando',
        waktu: '19:30 22/09/2024',
        isi:
            'Sebuah kucing berwarna oren yang tidak diketahui namanya telah ditemukan. Bulunya berwarna oren dengan corak belang yang mencolok.',
        isBalas: true,
        fotoProfil:
            'path/to/your/image.jpg', // Ganti dengan path ke gambar Anda
        onBalas: (String reply) {
          print('Balasan: $reply');
          // Perbarui state di widget Komentar
          setState(() {
            balasan.add(reply);
          });
        },
        balasan: balasan,
      ),
    );
  }
}

class KomentarWidget extends StatefulWidget {
  const KomentarWidget({
    Key? key,
    required this.nama,
    required this.waktu,
    required this.isi,
    this.isBalas = false,
    required this.fotoProfil,
    required this.onBalas,
    required this.balasan,
    this.isUser = false,
  }) : super(key: key);

  final String nama;
  final String waktu;
  final String isi;
  final bool isBalas;
  final String fotoProfil;
  final Function(String) onBalas;
  final List<String> balasan;
  final bool isUser;

  @override
  _KomentarWidgetState createState() => _KomentarWidgetState();
}

class _KomentarWidgetState extends State<KomentarWidget> {
  TextEditingController _replyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          padding: EdgeInsets.only(bottom: 100),
          children: [
            Container(
              margin: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage(widget.fotoProfil),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    widget.nama,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    widget.waktu,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Text(widget.isi),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (widget.balasan.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: widget.balasan.map((reply) {
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                backgroundImage: AssetImage(widget.fotoProfil),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          widget.nama,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          widget.waktu,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(reply),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: widget.isBalas
              ? Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  color: Colors.grey[200],
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _replyController,
                          decoration: InputDecoration(
                            hintText: 'Balas komentar...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(90),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () {
                          String reply = _replyController.text;
                          if (reply.isNotEmpty) {
                            widget.onBalas(reply);
                            _replyController.clear();
                          }
                        },
                      ),
                    ],
                  ),
                )
              : SizedBox.shrink(),
        ),
      ],
    );
  }
}