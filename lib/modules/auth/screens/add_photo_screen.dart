import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loveria/api/api.dart';
import 'package:loveria/config/routes/routing_constants.dart';
import 'package:loveria/utils/helpers/helpers.dart';
import 'package:loveria/utils/helpers/local_storage_enums.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddPhotoScreen extends StatefulWidget {
  @override
  _AddPhotoScreenState createState() => _AddPhotoScreenState();
}

class _AddPhotoScreenState extends State<AddPhotoScreen> {
  final picker = ImagePicker();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  List<File> photosList = [];
  List<String> userPhotosList = [];
  bool _isLoading = false;
  int imagePosition = 0;

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
                child: Column(
                  children: <Widget>[
                    SizedBox(height: kDefaultPadding * 2.5),
                    Text(
                      "Add Photos",
                      style: TextStyle(
                        color: kSecondaryTextColor,
                        fontSize: 28.0,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Roboto",
                      ),
                    ),
                    SizedBox(height: kDefaultPadding / 2),
                    Text(
                      "Add at least 2 photos to continue ",
                      style: TextStyle(
                        color: kHintTextColor,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Roboto",
                      ),
                    ),
                    SizedBox(height: kDefaultPadding * 2.5),
                    Row(
                      children: [
                        const SizedBox(width: kDefaultPadding),
                        _buildAddMedia(0),
                        const SizedBox(width: kDefaultPadding),
                        _buildAddMedia(1),
                        const SizedBox(width: kDefaultPadding),
                        _buildAddMedia(2),
                      ],
                    ),
                    const SizedBox(height: kDefaultPadding),
                    Row(
                      children: [
                        const SizedBox(width: kDefaultPadding),
                        _buildAddMedia(3),
                        const SizedBox(width: kDefaultPadding),
                        _buildAddMedia(4),
                        const SizedBox(width: kDefaultPadding),
                        _buildAddMedia(5),
                      ],
                    ),
                    const SizedBox(height: kDefaultPadding),
                    Row(
                      children: [
                        const SizedBox(width: kDefaultPadding),
                        _buildAddMedia(6),
                        const SizedBox(width: kDefaultPadding),
                        _buildAddMedia(7),
                        const SizedBox(width: kDefaultPadding),
                        _buildAddMedia(8),
                      ],
                    ),
                    SizedBox(height: kDefaultPadding * 6),
                    _isLoading
                        ? CircularLoading(color: kPrimaryColor)
                        : _buildNextButton(),
                    SizedBox(height: kDefaultPadding * 2.5),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _selectPhotosImage(int position) async {
    if (_isLoading) return;
    if (photosList.length > position) {
      setState(
        () {
          photosList.remove(photosList[position]);
          userPhotosList.remove(userPhotosList[position]);
        },
      );
    } else {
      var pickedImage = await picker.pickImage(source: ImageSource.gallery);
      if (pickedImage == null) return;
      setState(
        () {
          photosList.add(File(pickedImage.path));
          userPhotosList.add(pickedImage.path);
        },
      );
    }
  }

  Widget _buildAddMedia(int position) {
    bool isImage = false;

    if (photosList.length > (position)) {
      isImage = true;
    }
    return InkWell(
      onTap: () {
        _selectPhotosImage(position);
      },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(80.0),
              ),
              shape: BoxShape.rectangle,
            ),
            child: isImage
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(80.0),
                    child: Image.file(
                      photosList[position],
                      width: MediaQuery.of(context).size.width / 3 -
                          kDefaultPadding * 1.5,
                      height: MediaQuery.of(context).size.width / 3 -
                          kDefaultPadding * 1.5,
                      fit: BoxFit.cover,
                    ),
                  )
                : Image(
                    image: AssetImage("assets/images/profile_no_media.png"),
                    width: MediaQuery.of(context).size.width / 3 -
                        kDefaultPadding * 1.5,
                    height: MediaQuery.of(context).size.width / 3 -
                        kDefaultPadding * 1.5,
                  ),
          ),
          Positioned(
            right: 6,
            bottom: 6,
            child: photosList.length > position
                ? Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: kPrimaryTextColor,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0.0, 2.0),
                          blurRadius: 6.0,
                        )
                      ],
                    ),
                    child: const Icon(
                      Icons.close_rounded,
                      size: 16,
                      color: kPrimaryColor,
                    ),
                  )
                : Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0.0, 2.0),
                          blurRadius: 6.0,
                        )
                      ],
                    ),
                    child: const Icon(
                      Icons.add_rounded,
                      size: 16,
                      color: kPrimaryTextColor,
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildNextButton() {
    return RawMaterialButton(
      splashColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Ink(
        decoration: photosList.length > 1
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
              'CONTINUE',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 22.0,
                fontWeight: FontWeight.w700,
                color: photosList.length > 1
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
    if (photosList.length > 1) {
      bool internetConnected = await CheckInternet().checkInternet();

      if (internetConnected != true) {
        return ToastMaker().simpleErrorToast(checkInternetErrorMsg);
      }
      FocusScope.of(context).requestFocus(FocusNode());

      setState(() {
        _isLoading = true;
      });

      Map<String, dynamic> data = {};

      try {
        var i = 0;
        for (String file in userPhotosList) {
          data['imagePhotos[' + i.toString() + ']'] =
              await MultipartFile.fromFile(file,
                  filename: file.split('/').last);
          i++;
        }

        print(data);

        Response response = await CallApi()
            .postMultipartData(FormData.fromMap(data), uploadUserPhotosRoute);
        final SharedPreferences prefs = await _prefs;
        print(response);
        Map responseBody = response.data;
        if ((responseBody['success'] != null) &&
            (responseBody['success'] == true)) {
          var _user = prefs.getString(sUser);
          var user = json.decode(_user!);
          user['photos'] = userPhotosList;
          user['profile_pic'] = responseBody['user']['profile_pic'];
          prefs.setString(sUser, jsonEncode(user));
          setState(() {
            _isLoading = false;
          });
          await Navigator.of(context).pushNamed(locationPermissionRoute);
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
      }
    } else {
      ToastMaker().simpleErrorToast("Please add 2 photos");
    }
  }
}
