import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loveria/config/routes/routing_constants.dart';
import 'package:loveria/modules/auth/screens/add_photo_screen.dart';
import 'package:loveria/modules/auth/screens/avoid_someone_screen.dart';
import 'package:loveria/modules/auth/screens/birth_submit_screen.dart';
import 'package:loveria/modules/auth/screens/email_field_screen.dart';
import 'package:loveria/modules/auth/screens/name_submit_screen.dart';
import 'package:loveria/modules/auth/screens/school_submit_screen.dart';
import 'package:loveria/modules/navbar/screens/bottom_nav_screen.dart';
import 'package:loveria/utils/screens/screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case appOpeningRoute:
      return PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => AppOpenLoading());
    case loginViewRoute:
      return PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => LoginScreen());
    case loginOtpVerifyRoute:
      return PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) =>
              LoginOtpVerifyScreen(
                verificationId: '',
                mobile: '',
              ));
    case emailSubmitRoute:
      return PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => EmailFieldScreen());
    case createUserWithPhone:
      return PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) =>
              PhoneNumberScreen());
    case nameSubmitRoute:
      return PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => NameSubmitScreen());
    case schoolSubmitRoute:
      return PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) =>
              SchoolSubmitScreen());
    case avoidSomeOneRoute:
      return PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) =>
              AvoidSomeoneScreen());
    case birthSubmitRoute:
      return PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) =>
              BirthSubmitScreen());
    case setGenderRoute:
      return PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) =>
              ChooseGenderScreen());
    case interestViewRoute:
      return PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => InterestScreen());
    case uploadUserPhotosRoute:
      return PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => AddPhotoScreen());
    case locationPermissionRoute:
      return PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => LocatePermission());
    case bottomNavRoute:
      return PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => BottomNavScreen());
    case streamViewRoute:
      return PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => StreamScreen());

    default:
      return PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => LoginScreen());
  }
}
