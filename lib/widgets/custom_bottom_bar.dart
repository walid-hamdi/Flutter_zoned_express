import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import "../views/all.dart";

class CustomBottomBar extends StatefulWidget {
  const CustomBottomBar({Key? key}) : super(key: key);

  @override
  createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  int _selectedIndex = 0;

  // ignore: prefer_final_fields
  static List<Widget> _widgetOptions = [
    const HomeView(),
    const ExploreView(),
    const BookmarkView(),
    const Wrapper(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: GNav(
          haptic: true, // haptic feedback
          tabBorderRadius: 20,
          curve: Curves.easeInExpo, // tab animation curves
          duration: const Duration(milliseconds: 900), // tab animation duration
          gap: 4, // the tab button gap between icon and text
          color: Colors.black,
          tabMargin: const EdgeInsets.symmetric(
              horizontal: 10, vertical: 5), // unselected icon color
          activeColor: Colors.white, // selected icon and text color
          iconSize: 24, // tab button icon size
          tabBackgroundColor: Colors.black, // selected tab background color
          padding: const EdgeInsets.symmetric(
              horizontal: 6, vertical: 7), // navigation bar padding
          tabs: const [
            GButton(
              icon: Icons.home,
              text: 'Home',
            ),
            GButton(
              icon: Icons.explore_outlined,
              text: 'Explore',
            ),
            GButton(
              icon: Icons.bookmark_outline,
              text: 'Bookmark',
            ),
            GButton(
              icon: Icons.person,
              text: 'Profile',
            )
          ],
          selectedIndex: _selectedIndex,
          onTabChange: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}
