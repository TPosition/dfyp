import 'package:flutter/material.dart';
import '/history/view/history.dart';
import '/home/home.dart';
import '/profile/view/profile_page.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({final Key? key}) : super(key: key);
  static Page page() => const MaterialPage<void>(child: BottomNavBar());

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  final TextStyle _optionStyle = GoogleFonts.roboto(
      color: Colors.black, fontWeight: FontWeight.w500, fontSize: 14);
  final List<Widget> _widgetOptions = [
    const HomePage(),
    const HistoryPage(),
    const ProfilePage()
  ];

  @override
  Widget build(final BuildContext context) => Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (final index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: _selectedIndex == 0
                  ? Image.asset('assets/ico_home_selected.png')
                  : Image.asset('assets/ico_home.png'),
              label: 'Home',
            ),
            // BottomNavigationBarItem(
            //   icon: _selectedIndex == 1
            //       ? Image.asset('assets/ico_history_selected.png')
            //       : Image.asset('assets/ico_history.png'),
            //   title: Text(
            //     'History',
            //     style: _optionStyle,
            //   ),
            // ),
            // BottomNavigationBarItem(
            //   icon: _selectedIndex == 2
            //       ? Image.asset('assets/ico_profile_selected.png')
            //       : Image.asset('assets/ico_profile.png'),
            //   title: Text(
            //     'Profile',
            //     style: _optionStyle,
            //   ),
            // ),
          ],
        ),
      );
}
