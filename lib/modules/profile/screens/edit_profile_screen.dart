import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loveria/utils/data/data.dart';
import 'package:loveria/utils/helpers/constants.dart';
import 'package:loveria/utils/helpers/local_storage_enums.dart';
import 'package:loveria/utils/helpers/styles.dart';
import 'package:loveria/utils/screens/screen.dart';
import 'package:loveria/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController aboutmeController = TextEditingController();
  TextEditingController passionController = TextEditingController();
  TextEditingController jobTitleController = TextEditingController();
  TextEditingController schoolController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController livingInController = TextEditingController();

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  var user;

  @override
  void initState() {
    _getUserInfo();
    super.initState();
  }

  void _getUserInfo() async {
    SharedPreferences prefs = await _prefs;
    if (prefs.containsKey(sUser)) {
      var _user = prefs.getString(sUser);
      setState(() {
        user = json.decode(_user!);
        nameController.text = user['name'];
        aboutmeController.text = user['aboutMe'];
        jobTitleController.text = user['jobTitle'];
        companyController.text = user['company'];
        schoolController.text = user['school'];
        livingInController.text = user['city'];
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
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: TitleAppBar(headerName: 'Edit Profile', elevation: 0),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              Row(
                children: [
                  const SizedBox(width: kDefaultPadding),
                  _buildRemoveMedia(),
                  const SizedBox(width: kDefaultPadding),
                  _buildRemoveMedia(),
                  const SizedBox(width: kDefaultPadding),
                  _buildRemoveMedia(),
                ],
              ),
              const SizedBox(height: kDefaultPadding),
              Row(
                children: [
                  const SizedBox(width: kDefaultPadding),
                  _buildRemoveMedia(),
                  const SizedBox(width: kDefaultPadding),
                  _buildRemoveMedia(),
                  const SizedBox(width: kDefaultPadding),
                  _buildAddMedia(),
                ],
              ),
              const SizedBox(height: kDefaultPadding),
              Row(
                children: [
                  const SizedBox(width: kDefaultPadding),
                  _buildAddMedia(),
                  const SizedBox(width: kDefaultPadding),
                  _buildAddMedia(),
                  const SizedBox(width: kDefaultPadding),
                  _buildAddMedia(),
                ],
              ),
              const SizedBox(height: kDefaultPadding),
              _buildAddMediaButton(),
              const SizedBox(height: kDefaultPadding),
              Padding(
                padding: const EdgeInsets.all(kDefaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Name',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF474747),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter  your name';
                        }
                        return null;
                      },
                      controller: nameController,
                      minLines: 1,
                      maxLines: 1,
                      autocorrect: false,
                      decoration: const InputDecoration(
                        hintText: 'Enter  your name',
                        hintStyle: TextStyle(
                          color: Color(0xFFA2A2A2),
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.only(top: 10.0, left: 20.0),
                        // filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
                          borderSide: BorderSide(
                            color: Color(0xFFEAEAEC),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
                          borderSide: BorderSide(
                            color: Color(0xFFEAEAEC),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: kDefaultPadding),
                    const Text(
                      'About Me',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF474747),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'About Me...';
                        }
                        return null;
                      },
                      controller: aboutmeController,
                      minLines: 1,
                      maxLines: 1,
                      autocorrect: false,
                      decoration: const InputDecoration(
                        hintText: 'Write about you',
                        hintStyle: TextStyle(
                          color: Color(0xFFA2A2A2),
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.only(top: 10.0, left: 20.0),
                        // filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
                          borderSide: BorderSide(
                            color: Color(0xFFEAEAEC),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
                          borderSide: BorderSide(
                            color: Color(0xFFEAEAEC),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: kDefaultPadding),
                    const Text(
                      'Passions',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF474747),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Photograpghy, Art, Film';
                        }
                        return null;
                      },
                      controller: passionController,
                      minLines: 1,
                      maxLines: 1,
                      autocorrect: false,
                      decoration: const InputDecoration(
                        hintText: 'Write about your passions',
                        hintStyle: TextStyle(
                          color: Color(0xFFA2A2A2),
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.only(top: 10.0, left: 20.0),
                        // filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
                          borderSide: BorderSide(
                            color: Color(0xFFEAEAEC),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
                          borderSide: BorderSide(
                            color: Color(0xFFEAEAEC),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: kDefaultPadding),
                    const Text(
                      'Job Title',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF474747),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Add job title';
                        }
                        return null;
                      },
                      controller: jobTitleController,
                      minLines: 1,
                      maxLines: 1,
                      autocorrect: false,
                      decoration: const InputDecoration(
                        hintText: 'Add job title',
                        hintStyle: TextStyle(
                          color: Color(0xFFA2A2A2),
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.only(top: 10.0, left: 20.0),
                        // filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
                          borderSide: BorderSide(
                            color: Color(0xFFEAEAEC),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
                          borderSide: BorderSide(
                            color: Color(0xFFEAEAEC),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: kDefaultPadding),
                    const Text(
                      'Company',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF474747),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Add job company';
                        }
                        return null;
                      },
                      controller: companyController,
                      minLines: 1,
                      maxLines: 1,
                      autocorrect: false,
                      decoration: const InputDecoration(
                        hintText: 'Add job company',
                        hintStyle: TextStyle(
                          color: Color(0xFFA2A2A2),
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.only(top: 10.0, left: 20.0),
                        // filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
                          borderSide: BorderSide(
                            color: Color(0xFFEAEAEC),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
                          borderSide: BorderSide(
                            color: Color(0xFFEAEAEC),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    const Text(
                      'School',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF474747),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'School';
                        }
                        return null;
                      },
                      controller: schoolController,
                      minLines: 1,
                      maxLines: 1,
                      autocorrect: false,
                      decoration: const InputDecoration(
                        hintText: 'Add School',
                        hintStyle: TextStyle(
                          color: Color(0xFFA2A2A2),
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.only(top: 10.0, left: 20.0),
                        // filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
                          borderSide: BorderSide(
                            color: Color(0xFFEAEAEC),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
                          borderSide: BorderSide(
                            color: Color(0xFFEAEAEC),
                          ),
                        ),
                      ),
                    ),
                    const Text(
                      'Living In',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF474747),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Add city';
                        }
                        return null;
                      },
                      controller: schoolController,
                      minLines: 1,
                      maxLines: 1,
                      autocorrect: false,
                      decoration: const InputDecoration(
                        hintText: 'Add city',
                        hintStyle: TextStyle(
                          color: Color(0xFFA2A2A2),
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.only(top: 10.0, left: 20.0),
                        // filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
                          borderSide: BorderSide(
                            color: Color(0xFFEAEAEC),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
                          borderSide: BorderSide(
                            color: Color(0xFFEAEAEC),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRemoveMedia() {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(width: 2, color: kSecondaryColor),
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
              height: 107,
              width: 107,
              fit: BoxFit.cover,
              imageUrl: profile.profileImageUrl,
              useOldImageOnUrlChange: true,
              placeholder: (context, url) =>
                  const CupertinoActivityIndicator(radius: 15),
              errorWidget: (context, url, error) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
              Icons.close_rounded,
              size: 16,
              color: kPrimaryColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAddMediaButton() {
    return RawMaterialButton(
      splashColor: const Color(0xFFEAEAEC),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Ink(
        decoration: const BoxDecoration(
          gradient: kGradientAddMediaButtonStyle,
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
        ),
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: 217,
            minHeight: 36.0,
          ), // min sizes for Material buttons
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Add Media'.toUpperCase(),
              textAlign: TextAlign.center,
              style: const TextStyle(
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

  Widget _buildAddMedia() {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(80.0),
            ),
            shape: BoxShape.rectangle,
          ),
          child: const CircleAvatar(
            radius: 55,
            backgroundImage: AssetImage("assets/images/profile_no_media.png"),
          ),
        ),
        Positioned(
          right: 6,
          bottom: 6,
          child: Container(
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
    );
  }
}
