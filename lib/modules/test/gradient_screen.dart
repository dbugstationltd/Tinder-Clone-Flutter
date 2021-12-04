import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loveria/utils/helpers/styles.dart';

class GradientScreen extends StatefulWidget {
  const GradientScreen({Key? key}) : super(key: key);

  @override
  _GradientScreenState createState() => _GradientScreenState();
}

class _GradientScreenState extends State<GradientScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: kGradientPageStyle,
                ),
              ),
              Container(),
            ],
          ),
        ),
      ),
    );
  }
}


// Set<String> keys = prefs.getKeys();
//     print(keys);
//     keys.remove(sApiToken);