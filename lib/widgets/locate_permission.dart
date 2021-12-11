import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loveria/api/api.dart';
import 'package:loveria/config/routes/routing_constants.dart';
import 'package:loveria/utils/helpers/check_internet.dart';
import 'package:loveria/utils/helpers/constants.dart';
import 'package:loveria/utils/helpers/enums.dart';
import 'package:loveria/utils/helpers/local_storage_enums.dart';
import 'package:loveria/utils/helpers/styles.dart';
import 'package:loveria/utils/helpers/toast_maker.dart';
import 'package:loveria/utils/screens/screen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocatePermission extends StatefulWidget {
  const LocatePermission({Key? key}) : super(key: key);

  @override
  _LocatePermissionState createState() => _LocatePermissionState();
}

class _LocatePermissionState extends State<LocatePermission> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  bool _isLoading = false;
  var latitude;
  var longitude;

  @override
  void initState() {
    super.initState();
  }

  Future getCurrentLocation() async {
    // var lastPosition = await Geolocator.getLastKnownPosition();

    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      latitude = position.latitude;
      longitude = position.longitude;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Padding(
          padding: const EdgeInsets.all(36.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: kPrimaryTextColor,
                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(kDefaultPadding),
                  child: Column(
                    children: <Widget>[
                      const Image(
                        image: AssetImage('assets/images/location.png'),
                        height: 134,
                        width: 134,
                      ),
                      const SizedBox(height: 24.0),
                      const Text(
                        'Allow your Location',
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 26.0,
                            color: Color(0xFF474747),
                            fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 16.0),
                      const Text(
                        'We will need your location to give you a better experience',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 16.0,
                          color: Color(0xFFA2A2A2),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 133.0),
                      _isLoading
                          ? CircularLoading(color: kPrimaryColor)
                          : _buildAllowButton(),
                      const SizedBox(height: kDefaultPadding),
                      _isLoading ? SizedBox() : _buildNotNowButton(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNotNowButton() {
    return RawMaterialButton(
      splashColor: const Color(0xFFEAEAEC),
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 0.0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
        side: const BorderSide(color: kSecondaryColor),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: const <Widget>[
            Text(
              'Not Now',
              maxLines: 1,
              style: TextStyle(
                fontSize: 22.0,
                color: kSecondaryColor,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
      onPressed: () {
        Navigator.of(context).pushNamedAndRemoveUntil(
            bottomNavRoute, (Route<dynamic> route) => false);
      },
    );
  }

  Widget _buildAllowButton() {
    return RawMaterialButton(
      splashColor: const Color(0xFFEAEAEC),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Ink(
        decoration: const BoxDecoration(
          gradient: kGradientButtonStyle,
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
        ),
        child: Container(
          constraints: const BoxConstraints(
            minWidth: 88.0,
            minHeight: 36.0,
          ), // min sizes for Material buttons
          alignment: Alignment.center,
          child: const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              'Allow Location',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 22.0,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      onPressed: _handleAllowBtn,
    );
  }

  Future _handleAllowBtn() async {
    bool internetConnected = await CheckInternet().checkInternet();

    if (internetConnected != true) {
      return ToastMaker().simpleErrorToast(checkInternetErrorMsg);
    }
    await getCurrentLocation();

    FocusScope.of(context).requestFocus(FocusNode());

    setState(() {
      _isLoading = true;
    });

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      setState(() {
        _isLoading = false;
      });

      return ToastMaker().simpleErrorToast(locationDisableErrorMsg);
    }

    if (latitude == null || longitude == null) {
      LocationPermission permission = await Geolocator.checkPermission();
      if ((permission == LocationPermission.denied) ||
          (permission == LocationPermission.deniedForever)) {
        setState(() {
          _isLoading = false;
        });
        return ToastMaker().simpleErrorToast(locationPermissionErrorMsg);
      }
    }

    var data = {
      'latitude': latitude,
      'longitude': longitude,
    };

    try {
      Response response = await CallApi().postData(data, changeLocationRoute);
      final SharedPreferences prefs = await _prefs;
      Map responseBody = response.data;
      if ((responseBody['success'] != null) &&
          (responseBody['success'] == true)) {
        var _user = prefs.getString(sUser);
        var user = json.decode(_user!);
        user['latitude'] = latitude;
        user['longitude'] = longitude;
        prefs.setString(sUser, jsonEncode(user));
        setState(() {
          _isLoading = false;
        });
        await Navigator.of(context).pushNamedAndRemoveUntil(
            appOpeningRoute, (Route<dynamic> route) => false);
      } else {
        if (responseBody['message'] != null) {
          ToastMaker().simpleErrorToast(responseBody['message']);
        } else {
          ToastMaker().simpleErrorToast(defaultErrorMsg);
        }
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ToastMaker().simpleErrorToast(defaultErrorMsg);
    }
  }
}
