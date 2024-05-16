class ApiService {
  static Uri url(url) {
    Uri Server = Uri.parse("http://172.16.110.59:8000/mobile/" + url);
    return Server;
  }

  static Uri urlApi(url) {
    Uri server = Uri.parse("http://172.16.110.59:8000/api/" + url);
    return server;
  }

  static String urlGambar(url) {
    String Server = "http://172.16.110.59/kucari_web/public/mobile/uploads/" + url;
    return Server;
  }

  // static Uri url(url) {
  //   Uri Server = Uri.parse("http://192.168.1.6/webKucari/public/mobile/" + url);
  //   return Server;
  // }

  // static Uri urlApi(url) {w
  //   Uri server = Uri.parse("http://192.168.1.6/webKucari/api/" + url);
  //   return server;
  // }

  // static String urlGambar(url) {
  //   String Server = "http://192.168.1.6/webKucari/public/mobile/uploads/" + url;
  //   return Server;
  // }









  // static String urlGambar(url) {
  //   String Server = "assets/images/" + url;
  //   return Server;
  // }

  //  static String urlString(String url) {
//     String Server = "http://172.17.202.43/Baticraft/baticraft/fh_db/" + url;
//     return Server;
// }
}
