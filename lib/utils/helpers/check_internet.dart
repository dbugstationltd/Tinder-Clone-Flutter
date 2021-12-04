import 'dart:io';

class CheckInternet {
  checkInternet() async {
    bool connectivity = false;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        connectivity = true;
      }
    } on SocketException catch (_) {
      connectivity = false;
    }
    return connectivity;
  }
}
