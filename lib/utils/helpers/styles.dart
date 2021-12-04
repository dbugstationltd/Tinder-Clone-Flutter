import 'package:flutter/material.dart';
import 'package:loveria/utils/helpers/constants.dart';

const kLabelStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.w700,
  fontSize: 16.0,
  fontFamily: 'Roboto',
);

const kGradientPageStyle = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    kPrimaryColor,
    kSecondaryColor,
  ],
  stops: [0.1, 0.7],
);

const kGradientCardStyle = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Colors.transparent,
    Colors.black,
  ],
  stops: [0.4, 1],
);

const kGradientButtonStyle = LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  colors: [
    kPrimaryColor,
    kSecondaryColor,
  ],
  stops: [0.01, 1.7],
);

const kGradientIconStyle = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Color(0xFF4D9AF5),
    Color(0xFF77D9FA),
  ],
  stops: [0.1, 0.7],
);

const kGradientLiveStyle = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Color(0xFFF74884),
    Color(0xFFF62859),
  ],
  stops: [0.1, 0.7],
);

const kGradientChatTextStyle = LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  colors: [
    Color(0xFF9640F5),
    Color(0xFFB781F3),
  ],
  stops: [0.1, 0.7],
);

const kGradientNextButtonStyle = LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  colors: [
    Color(0xFFB781F3),
    Color(0xFF9640F5),
  ],
  stops: [0.1, 0.7],
);

const kGradientDefauldButtonStyle = LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  colors: [
    Color(0xFFEE41A3),
    Color(0xFFAE2AE5),
  ],
  stops: [0.1, 0.7],
);

const kGradientAddMediaIconStyle = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Color(0xFFEE41A3),
    Color(0xFFAE2AE5),
  ],
  stops: [0.1, 0.7],
);

const kGradientAddMediaButtonStyle = LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  colors: [
    Color(0xFFEE41A3),
    Color(0xFFAE2AE5),
  ],
  stops: [0.1, 0.7],
);

const kGradientChatIconStyle = LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  colors: [
    Color(0xFF77D9FA),
    Color(0xFF4D9AF5),
  ],
  stops: [0.1, 0.7],
);

const kGradientBlackButtonStyle = LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  colors: [
    Color(0xFF6D6D82),
    Color(0xFF3A3A5A),
  ],
  stops: [0.01, 1.7],
);

const dTabTextStyle = TextStyle(
  fontSize: 14.0,
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w700,
);