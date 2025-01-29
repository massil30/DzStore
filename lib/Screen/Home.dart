import 'package:dzstore/Screen/Home/Myorder.dart';
import 'package:dzstore/Screen/settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:residemenu/residemenu.dart';

import '../transltae.dart';
import 'Home/initialpage.dart';

class Home extends StatefulWidget {
  static String id = "Home";
  @override
  _HomeState createState() => _HomeState();
}

int index = 0;

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    var tabs = [
      home(
        context,
      ),
      orders(),
      Text("ok")
    ];
    var lan = Provider.of<Translate>(context, listen: true);

    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.deepPurple,
          currentIndex: index,
          type: BottomNavigationBarType.shifting,
          onTap: (value) {
            setState(() {
              index = value;
            });
          },
          unselectedItemColor: Colors.white,
          selectedFontSize: 18,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          iconSize: 25,
          items: [
            BottomNavigationBarItem(
              backgroundColor: Colors.black,
              icon: Icon(
                Icons.home,
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.black,
              icon: Icon(Icons.featured_play_list),
              label: "My Orders",
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.black,
              icon: Icon(
                Icons.settings,
              ),
              label: "Settings",
            ),
          ],
        ),
        body: Directionality(
            textDirection:
                lan.isEn == true ? TextDirection.ltr : TextDirection.rtl,
            child: tabs[index]));
  }
}
