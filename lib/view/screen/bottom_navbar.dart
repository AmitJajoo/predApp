import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:predapp/const.dart';
import 'package:predapp/view/screen/home_screen.dart';
import 'package:predapp/view/screen/record.dart';
import 'package:predapp/view/screen/widget/about.dart';

class BottomNavBar extends StatefulWidget {
  BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int pageIndex = 0;
  List pages = [
    Button(),
    Record(),
    About()
    // HomeScreen(),
    // FeedsSreen(),
    // SearchScreen(),
    // CardScreen(),
    // UploadScreen(),
    // ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[pageIndex],
      bottomNavigationBar: CupertinoTabBar(
        onTap: (index) {
          setState(() {
            pageIndex = index;
          });
        },
        currentIndex: pageIndex,
        activeColor: textButtonColor,
        inactiveColor: Colors.white,
        backgroundColor: Color(0xffDC1C13),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 30,
              ),
              label: 'Home',
              backgroundColor: backgroundColor),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.file_copy,
                size: 30,
              ),
              label: 'Record',
              backgroundColor: backgroundColor),
              BottomNavigationBarItem(
              icon: Icon(
                Icons.info_outline_rounded,
                size: 30,
              ),
              label: 'About',
              backgroundColor: backgroundColor),
          // BottomNavigationBarItem(
          //     icon: Icon(
          //       Icons.search,
          //       size: 30,
          //     ),
          //     label: 'Search',
          //     backgroundColor: backgroundColor),
          // BottomNavigationBarItem(
          //     icon: Icon(
          //       Icons.shopping_bag,
          //       size: 30,
          //     ),
          //     label: 'Cart',
          //     backgroundColor: backgroundColor),
          // BottomNavigationBarItem(
          //     icon: Icon(
          //       Icons.upload,
          //       size: 30,
          //     ),
          //     label: 'Upload',
          //     backgroundColor: backgroundColor),
          // BottomNavigationBarItem(
          //     icon: Icon(
          //       Icons.person,
          //       size: 30,
          //     ),
          //     label: 'Person',
          //     backgroundColor: backgroundColor),
        ],
        // currentIndex: _selectedIndex,
        //selectedItemColor: Colors.amber[800],
        // onTap: _onItemTapped,
      ),
    );
  }
}
