class ApiService {
  // static Uri url(url) {
  //   Uri Server = Uri.parse("http://172.16.103.230:8000/mobile/" + url);
  //   return Server;
  // }

  // static Uri urlApi(url) {
  //   Uri server = Uri.parse("http://172.16.103.230:8000/api/" + url);
  //   return server;
  // }
 
  // static String urlGambar(url) {
  //   String Server = "http://172.16.103.230/kucari_web/public/mobile/uploads/" + url;
  //   return Server;
  // }

  static Uri url(url) {
    Uri Server = Uri.parse("https://kucari.tifnganjuk.com/mobile/" + url);
    return Server;
  }

  static Uri urlApi(url) {
    Uri server = Uri.parse("https://kucari.tifnganjuk.com/api/" + url);
    return server;
  }

  static String urlGambar(url) {
    String Server = "https://kucari.tifnganjuk.com/public/mobile/uploads/" + url;
    return Server;
  }









  // static String urlGambar(url) {
  //   String Server = "assets/images/" + url;
  //   return Server;
  // }

  //  static String urlString(String url) {
//     String Server = "http://172.17.202.43/Baticraft/baticraft/fh_db/" + url;
//     return Server;
// }
}
