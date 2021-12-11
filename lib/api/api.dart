import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:loveria/utils/helpers/enums.dart';
import 'package:dio/dio.dart';
import 'package:loveria/utils/helpers/local_storage_enums.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CallApi {
  final String _url = apiUrl;
  Dio dio = Dio();

  Future<String> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else {
      AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.androidId; // unique ID on Android
    }
  }

  _getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(sApiToken);
  }

  postData(data, apiUrl) async {
    var fullUrl = _url + apiUrl;

    var token = await _getToken();
    String deviceId = await _getId();
    return await dio.post(
      fullUrl,
      data: data,
      options: Options(
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'device-id': deviceId,
          'Authorization': 'Bearer $token',
        },
      ),
    );
  }

  postMultipartData(data, apiUrl) async {
    var fullUrl = _url + apiUrl;
    var token = await _getToken();
    String deviceId = await _getId();
    return await dio.post(
      fullUrl,
      data: data,
      options: Options(
        headers: {
          'device-id': deviceId,
          'Authorization': 'Bearer $token',
        },
      ),
    );
  }

  getData(apiUrl) async {
    var fullUrl = _url + apiUrl;
    var token = await _getToken();
    String deviceId = await _getId();
    return await dio.get(
      fullUrl,
      options: Options(
        headers: {
          'device-id': deviceId,
          'Authorization': 'Bearer $token',
        },
      ),
    );
  }
}
