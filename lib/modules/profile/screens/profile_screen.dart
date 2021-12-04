import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loveria/api/api.dart';
import 'package:loveria/config/routes/routing_constants.dart';
import 'package:loveria/models/models.dart';
import 'package:loveria/modules/profile/repositories/dot_generate.dart';
import 'package:loveria/utils/data/data.dart';
import 'package:loveria/utils/helpers/constants.dart';
import 'package:loveria/utils/helpers/helpers.dart';
import 'package:loveria/utils/helpers/local_storage_enums.dart';
import 'package:loveria/utils/helpers/styles.dart';
import 'package:loveria/utils/screens/screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:image/image.dart' as ImD;
import 'package:path_provider/path_provider.dart';

class ProfileScreen extends StatefulWidget {
  final Profile currentUser;
  const ProfileScreen({Key? key, required this.currentUser}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  var user;
  String profileImage = defaultNoImageUrl;
  final picker = ImagePicker();
  File? selectedImage;
  String imageName = Uuid().v4();
  String selectedImagePath = localProfilePicUrl;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) => _getUserInfo());
  }

  void _getUserInfo() async {
    SharedPreferences prefs = await _prefs;
    if (prefs.containsKey(sUser)) {
      var _user = prefs.getString(sUser);
      setState(() {
        user = json.decode(_user!);
        profileImage = photoBucket + user['profile_pic'];
        print(user);
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => LoginScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height / 1.7,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            "assets/images/profile_background.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: kDefaultPadding*4),
                        InkWell(
                          onTap: () => _selectProfileImage(),
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 2, color: Colors.white),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(80.0),
                                  ),
                                  shape: BoxShape.rectangle,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                    80,
                                  ),
                                  child: CachedNetworkImage(
                                    height: 139,
                                    width: 139,
                                    fit: BoxFit.cover,
                                    imageUrl: profileImage,
                                    useOldImageOnUrlChange: true,
                                    placeholder: (context, url) =>
                                        const CupertinoActivityIndicator(
                                            radius: 15),
                                    errorWidget: (context, url, error) =>
                                        Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const <Widget>[
                                        Icon(
                                          Icons.error,
                                          color: Colors.black,
                                          size: 30,
                                        ),
                                        Text(
                                          "Enable to load",
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 6,
                                bottom: 6,
                                child: Container(
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
                                    Icons.add_rounded,
                                    size: 24,
                                    color: kPrimaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: kDefaultPadding / 1),
                        Text(
                          user != null ? user['name'] : "",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 28,
                          ),
                        ),
                        Stack(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 60),
                              child: Align(
                                alignment: Alignment.center,
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: 70,
                                      width: 70,
                                      child: FloatingActionButton(
                                        heroTag: UniqueKey(),
                                        splashColor: const Color(0xFFEE41A3),
                                        backgroundColor:
                                            const Color(0xFFEE41A3),
                                        child: const Icon(
                                          Icons.add_a_photo,
                                          color: Colors.white,
                                          size: 32,
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            CupertinoPageRoute(
                                              builder: (context) =>
                                                  const AddMediaScreen(),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        "ADD MEDIA",
                                        style: TextStyle(
                                          color: kHintTextColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                                padding:
                                    const EdgeInsets.only(left: 30, top: 30),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    children: <Widget>[
                                      FloatingActionButton(
                                        splashColor: Colors.white,
                                        heroTag: UniqueKey(),
                                        backgroundColor: Colors.white,
                                        child: const Icon(
                                          Icons.settings,
                                          color: Colors.grey,
                                          size: 28,
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            CupertinoPageRoute(
                                              builder: (context) =>
                                                  const ProfileSettingsScreen(),
                                            ),
                                          );
                                        },
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          "SETTINGS",
                                          style: TextStyle(
                                            color: kHintTextColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 30, top: 30),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Column(
                                  children: <Widget>[
                                    FloatingActionButton(
                                      heroTag: UniqueKey(),
                                      splashColor: Colors.white,
                                      backgroundColor: Colors.white,
                                      child: const Icon(
                                        Icons.edit,
                                        color: Colors.grey,
                                        size: 28,
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                            builder: (context) =>
                                                const EditProfileScreen(),
                                          ),
                                        );
                                      },
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        "EDIT INFO",
                                        style: TextStyle(
                                          color: kHintTextColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: kDefaultPadding / 2,
                      vertical: kDefaultPadding * 5,
                    ),
                    child: Container(
                      height: 230,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(23.0),
                        ),
                        color: Color(0xFFFFF6FB),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Like Profiles around the world',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'Passport to anywhere with Loveria plus',
                            style: TextStyle(
                              fontSize: 14.0,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 22),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              dot(),
                              dot(),
                              dot(),
                              dot(),
                              dot(),
                              dot(),
                              dot(),
                              dot(),
                              dot(),
                              dot(),
                              dot(),
                            ],
                          ),
                          const SizedBox(height: 40),
                          _buildSubscriptionButton(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _selectProfileImage() async {
    var pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage == null) return;
    setState(
      () {
        selectedImage = File(pickedImage.path);
        selectedImagePath = pickedImage.path;
      },
    );
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.setString(sUserLocalProfilePicPath, pickedImage.path);
    var data = {
      'profilePic': await MultipartFile.fromFile(selectedImagePath,
          filename: selectedImagePath.split('/').last),
    };

    try {
      Response response = await CallApi()
          .postMultipartData(FormData.fromMap(data), updateProfilePic);
      final SharedPreferences prefs = await _prefs;
      var responseBody = await response.data;
      var _user = prefs.getString(sUser);
      var user = json.decode(_user!);
      user['profile_pic'] = responseBody['imagePath'];
      await prefs.setString(sUser, jsonEncode(user));
      setState(() {
        profileImage = photoBucket + responseBody['imagePath'];
      });
      if (responseBody['message'] != null) {
        ToastMaker().simpleToast(responseBody['message']);
      }
    } catch (e) {
      ToastMaker().simpleErrorToast(defaultErrorMsg);
    }
  }

  Widget _buildSubscriptionButton() {
    return RawMaterialButton(
      splashColor: const Color(0xFFEAEAEC),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Ink(
        decoration: const BoxDecoration(
          gradient: kGradientChatIconStyle,
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
        ),
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: 283,
            minHeight: 36.0,
          ), // min sizes for Material buttons
          alignment: Alignment.center,
          child: const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              'My Ashiqui Plus',
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
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SubscriptionWindow(),
          ),
        );
      },
    );
  }
}
