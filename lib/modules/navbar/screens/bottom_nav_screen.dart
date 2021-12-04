import 'package:flutter/material.dart';
import 'package:loveria/modules/search/screens/search_screen.dart';
import 'package:loveria/utils/data/data.dart';
import 'package:loveria/utils/helpers/constants.dart';
import 'package:loveria/utils/screens/screen.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({Key? key}) : super(key: key);

  @override
  _BottomNavScreenState createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  final List _screens = [
    const SearchScreen(),
    const DiscoverScreen(),
    const ChatScreen(),
    const StreamScreen(),
    const ProfileScreen(currentUser: profile),
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      extendBody: true,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        unselectedItemColor: Colors.grey,
        elevation: 10.0,
        items: [
          Icons.home,
          Icons.star,
          Icons.forum,
          Icons.sensors,
          Icons.person,
        ]
            .asMap()
            .map(
              (key, value) => MapEntry(
                key,
                BottomNavigationBarItem(
                  label: '',
                  activeIcon: ShaderMask(
                    blendMode: BlendMode.srcATop,
                    shaderCallback: (Rect bounds) {
                      return const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: <Color>[
                          kPrimaryColor,
                          kSecondaryColor,
                        ],
                        tileMode: TileMode.repeated,
                        stops: [0.1, 0.7],
                      ).createShader(bounds);
                    },
                    child: Icon(value, size: 27),
                  ),
                  icon: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 6.0,
                      horizontal: 16.0,
                    ),
                    decoration: BoxDecoration(
                      color: _currentIndex == key
                          ? Colors.blue[600]
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Icon(value, size: 27.0),
                  ),
                ),
              ),
            )
            .values
            .toList(),
      ),
    );
  }
}
