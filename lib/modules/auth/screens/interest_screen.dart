import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loveria/api/api.dart';
import 'package:loveria/config/routes/routing_constants.dart';
import 'package:loveria/models/models.dart';
import 'package:loveria/modules/auth/screens/add_photo_screen.dart';
import 'package:loveria/utils/helpers/check_internet.dart';
import 'package:loveria/utils/helpers/constants.dart';
import 'package:loveria/utils/helpers/enums.dart';
import 'package:loveria/utils/helpers/local_storage_enums.dart';
import 'package:loveria/utils/helpers/styles.dart';
import 'package:loveria/utils/helpers/toast_maker.dart';
import 'package:loveria/utils/screens/screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InterestScreen extends StatefulWidget {
  const InterestScreen({Key? key}) : super(key: key);

  @override
  _InterestScreenState createState() => _InterestScreenState();
}

class _InterestScreenState extends State<InterestScreen> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  bool _isLoading = false;
  List<int> interestList = [];

  List<Interest> _interests = [];

  List<Interest> get interests => _interests;

  @override
  void initState() {
    _checkLoggedInUser();
    _getInterestList();
    super.initState();
  }

  void _checkLoggedInUser() async {
    SharedPreferences prefs = await _prefs;

    if (!prefs.containsKey(sApiToken)) {
      await Navigator.of(context).pushNamedAndRemoveUntil(
          loginViewRoute, (Route<dynamic> route) => false);
    }
  }

  Future _getInterestList() async {
    bool internetConnected = await CheckInternet().checkInternet();

    if (internetConnected != true) {
      return ToastMaker().simpleErrorToast('Check your internet connection.');
    }
    FocusScope.of(context).requestFocus(FocusNode());

    try {
      // FormData formData = new FormData.fromMap(data);
      Response response = await CallApi().getData('/getInterestList');
      Map responseBody = response.data;
      if (responseBody['status'] != null) {
        if (responseBody['status'] == 'success') {
          var interestObjJson = responseBody['data'] as List;

          setState(() {
            _interests = interestObjJson
                .map((tagJson) => Interest.fromJson(tagJson))
                .toList();
          });
        } else {
          await Navigator.of(context).pushNamedAndRemoveUntil(
              loginViewRoute, (Route<dynamic> route) => false);
          if (responseBody['message'] != null) {
            ToastMaker().simpleErrorToast(responseBody['message']);
          } else {
            ToastMaker().simpleErrorToast(defaultErrorMsg);
          }
        }
      }
    } catch (e) {
      ToastMaker().simpleErrorToast(defaultErrorMsg);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) =>
            GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(kDefaultPadding),
                  child: Center(
                    child: Column(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(top: kDefaultPadding * 2),
                          child: Text(
                            "Passions",
                            style: TextStyle(
                              color: kSecondaryTextColor,
                              fontSize: 26.0,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Roboto",
                            ),
                          ),
                        ),
                        SizedBox(height: kDefaultPadding * 2.5),
                        _buildInterestItems(),
                        SizedBox(height: kDefaultPadding * 2.5),
                        _isLoading
                            ? CircularLoading(color: kPrimaryColor)
                            : _buildNextButton(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInterestItems() => Wrap(
        direction: Axis.horizontal,
        spacing: 4.0,
        runSpacing: 4,
        children: _interests.map((item) => _buildInterest(item)).toList(),
      );

  Widget _buildInterest(Interest item) => FittedBox(
        child: InkWell(
          onTap: () {
            if (interestList.contains(item.id)) {
              setState(() {
                interestList.remove(item.id);
              });
            } else {
              if (interestList.length > 5) {
                ToastMaker().simpleErrorToast("Passions limit is 6");
              } else {
                setState(() {
                  interestList.add(item.id);
                  interestList.toSet().toList();
                });
              }
            }
          },
          child: Container(
            decoration: BoxDecoration(
              gradient: interestList.contains(item.id)
                  ? kGradientButtonStyle
                  : kGradientBlackButtonStyle,
              borderRadius: BorderRadius.circular(24),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 4,
            ),
            child: Row(
              children: [
                Text(
                  item.interestName,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: kPrimaryTextColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                interestList.contains(item.id)
                    ? Icon(
                        Icons.done_rounded,
                        color: kPrimaryTextColor,
                      )
                    : Icon(
                        Icons.add_rounded,
                        color: kPrimaryTextColor,
                      ),
              ],
            ),
          ),
        ),
      );

  Widget _buildNextButton() {
    return RawMaterialButton(
      splashColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Ink(
        decoration: interestList.length > 1
            ? BoxDecoration(
                gradient: kGradientDefauldButtonStyle,
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
              )
            : BoxDecoration(
                color: kDisableColor,
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
              ),
        child: Container(
          constraints: BoxConstraints(
            maxWidth: 310.0,
          ), // min sizes for Material buttons
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              'CONTINUE (${interestList.length}/6)',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 22.0,
                fontWeight: FontWeight.w700,
                color: interestList.length > 1
                    ? kPrimaryTextColor
                    : kSecondaryTextColor,
              ),
            ),
          ),
        ),
      ),
      onPressed: _handleNextBtn,
    );
  }

  void _handleNextBtn() async {
    if (interestList.length > 1) {
      bool internetConnected = await CheckInternet().checkInternet();

      if (internetConnected != true) {
        return ToastMaker().simpleErrorToast(checkInternetErrorMsg);
      }
      FocusScope.of(context).requestFocus(FocusNode());

      setState(() {
        _isLoading = true;
      });

      var data = {
        'interestsList': interestList,
      };

      try {
        // FormData formData = new FormData.fromMap(data);
        Response response = await CallApi().postData(data, interestViewRoute);
        final SharedPreferences prefs = await _prefs;
        Map responseBody = response.data;
        if ((responseBody['success'] != null) &&
            (responseBody['success'] == true)) {
          var _user = prefs.getString(sUser);
          var user = json.decode(_user!);
          user['interestsList'] = interestList;
          prefs.setString(sUser, jsonEncode(user));
          setState(() {
            _isLoading = false;
          });
          await Navigator.of(context).pushNamed(uploadUserPhotosRoute);
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

      setState(() {
        _isLoading = false;
      });
    } else {
      ToastMaker().simpleErrorToast("Please add passions");
    }
  }
}
