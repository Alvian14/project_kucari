import 'dart:convert';

class Postingan {
  String kategori;
  String deskripsi;
  String tanggalPostingan;
  String jamPostingan;
  String fotoPostingan;
  String idPostingan;

  Postingan({
    required this.kategori,
    required this.deskripsi,
    required this.tanggalPostingan,
    required this.jamPostingan,
    required this.fotoPostingan,
    required this.idPostingan,
  });

  factory Postingan.fromJson(Map<String, dynamic> json) => Postingan(
        kategori: json["kategori"],
        deskripsi: json["deskripsi"],
        tanggalPostingan: json["tanggal_postingan"],
        jamPostingan: json["jam_postingan"],
        fotoPostingan: json["foto_postingan"],
        idPostingan: json["id_postingan"],
      );

  Map<String, dynamic> toJson() => {
        "kategori": kategori,
        "deskripsi": deskripsi,
        "tanggal_postingan": tanggalPostingan,
        "jam_postingan": jamPostingan,
        "foto_postingan": fotoPostingan,
        "id_postingan": idPostingan,
      };

  static List<Postingan> toList(List<dynamic> str){
    return str.map((e) => Postingan.fromJson(e)).toList();
  }

  static String postinganToJson(List<Postingan> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
}
