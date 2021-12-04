import 'package:flutter/material.dart';
import 'package:loveria/config/routes/routing_constants.dart';
import 'package:loveria/utils/helpers/constants.dart';
import 'package:loveria/utils/helpers/styles.dart';
import 'package:loveria/utils/screens/screen.dart';

class SaveSteamDialog extends StatelessWidget {
  final String message;
  final Function confirmTask;

  const SaveSteamDialog(
      {Key? key, required this.message, required this.confirmTask})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonBarTheme(
      data: const ButtonBarThemeData(alignment: MainAxisAlignment.center),
      child: AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            Text(
              "Save",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: kSuccessColor,
                fontSize: 32,
              ),
            ),
            Text(
              "or",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: kSecondaryTextColor,
                fontSize: 32,
              ),
            ),
            Text(
              "Close",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: kPrimaryColor,
                fontSize: 32,
              ),
            ),
          ],
        ),
        content: const Text(
          "this stream?",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: kSecondaryTextColor,
            fontSize: 32,
          ),
          textAlign: TextAlign.center,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
        contentPadding: const EdgeInsets.all(kDefaultPadding/2),
        actionsPadding: const EdgeInsets.all(kDefaultPadding),
        actions: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              SizedBox(
                width: 100,
                child: _buildSaveButton(context),
              ),
              SizedBox(
                width: 100,
                child: _buildCloseButton(context),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildSaveButton(BuildContext context) {
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
              'Save',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 18.0,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      onPressed: () {
        Navigator.of(context).pushNamedAndRemoveUntil(
          bottomNavRoute, (Route<dynamic> route) => false);
      },
    );
  }

  Widget _buildCloseButton(BuildContext context) {
    return RawMaterialButton(
      splashColor: const Color(0xFFEAEAEC),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Ink(
        decoration: const BoxDecoration(
          gradient: kGradientLiveStyle,
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
        ),
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: 286.0,
            minHeight: 36.0,
          ), // min sizes for Material buttons
          alignment: Alignment.center,
          child: const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              'Close',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 18.0,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      onPressed: () {
        Navigator.of(context).pushNamedAndRemoveUntil(
          bottomNavRoute, (Route<dynamic> route) => false);
      },
    );
  }
}
