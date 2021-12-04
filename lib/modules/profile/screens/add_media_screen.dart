import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loveria/utils/data/data.dart';
import 'package:loveria/utils/helpers/constants.dart';
import 'package:loveria/utils/helpers/styles.dart';
import 'package:loveria/utils/screens/screen.dart';

class AddMediaScreen extends StatefulWidget {
  const AddMediaScreen({Key? key}) : super(key: key);

  @override
  _AddMediaScreenState createState() => _AddMediaScreenState();
}

class _AddMediaScreenState extends State<AddMediaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: TitleAppBar(headerName: 'Create New', elevation: 0),
      ),
      body: Column(
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
              _buildRemoveMedia(),
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
          _buildCaptureFromCameraButton(),
        ],
      ),
    );
  }

  Widget _buildRemoveMedia() {
    return Container(
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
          child:  Padding(
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
    return Container(
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
    );
  }

  Widget _buildCaptureFromCameraButton() {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: RawMaterialButton(
        splashColor: const Color(0xFFEAEAEC),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Ink(
          decoration: const BoxDecoration(
            gradient: kGradientChatIconStyle,
            borderRadius: BorderRadius.all(Radius.circular(16.0)),
          ),
          child: Container(
            constraints: const BoxConstraints(), // min sizes for Material buttons
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 31.0),
              child: Row(
                children:  [
                  const Icon(
                    Icons.photo_camera,
                    color: Colors.white,
                    size: 48.0,
                  ),
                  const SizedBox(
                    width: 24.0,
                  ),
                  Text(
                    'Capture From Camera'.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 18.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        onPressed: () {},
      ),
    );
  }
}
