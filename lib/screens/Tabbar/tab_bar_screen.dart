import 'package:flutter/material.dart';
import 'package:pos/screens/barcode_screen.dart';
import 'package:pos/screens/main_screen.dart';
import 'package:pos/screens/printer_screen.dart';
import 'package:pos/screens/splash_screen.dart';
import 'package:pos/screens/support_screen.dart';
import 'package:pos/utils/constants/app_constants.dart';
import 'package:pos/utils/constants/font_constants.dart';

import '../../utils/global.dart';

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  List _userOptions = [];

  @override
  void initState() {
    _userOptions = [
      {"icon": "sale", "title": AppConstants.sale},
      {"icon": "support", "title": AppConstants.support},
      {"icon": "printer", "title": AppConstants.printer},
      {"icon": "barcode", "title": AppConstants.barcodeScanner},
      {
        "icon": "return",
        "title": "logout",
        "onTap": () {
          Global.storageService
              .removeUser()
              .then((value) => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SplashScreen(),
                  ),
                  (route) => false));
        }
      },
    ];
    super.initState();
  }

  int selectedDrawer = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: scaffoldKey,
      backgroundColor: Colors.white,
      drawer: _buildDrawer(),
      body: _buildUserBody(),
    );
  }

  Widget _buildUserBody() {
    switch (selectedDrawer) {
      case 0:
        return const MainScreen();
      case 1:
        return const SupportScreen();
      case 2:
        return const PrinterScreen();
      case 3:
        return const BarcodeScreen();
      default:
        return const MainScreen();
    }
  }

  Widget _buildDrawer() => Drawer(
        backgroundColor: Colors.white,
        child: Column(
          children: [
            DrawerHeader(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                        onPressed: () {
                          scaffoldKey.currentState?.closeDrawer();
                        },
                        icon: Image.asset("images/green_back_icon.png")),
                  ),
                  const SizedBox(height: 16),
                  Image.asset(
                    "images/logo_e.png",
                    scale: 3,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: List.generate(_userOptions.length, (index) {
                  return _buildDrawerItem(index);
                }),
              ),
            ),
            const Spacer(),
            const Align(
              alignment: Alignment.center,
              child: Text(
                "©Copyrights E-cart Express 2022.",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: Color(0xffC1BDBD),
                  fontFamily: FontConstants.regular,
                ),
              ),
            ),
            const SizedBox(height: 25),
          ],
        ),
      );

  Widget _buildDrawerItem(index) => ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        onTap: _userOptions[index]["onTap"] ??
            () {
              scaffoldKey.currentState?.closeDrawer();
              if (mounted) {
                setState(() {
                  selectedDrawer = index;
                });
              }
            },
        minLeadingWidth: 30,
        leading: Image.asset(
          "images/${_userOptions[index]["icon"]}_icon.png",
          scale: 3,
          color: selectedDrawer == index
              ? const Color(0xff15582A)
              : const Color(0xff5C1F5A),
        ),
        tileColor:
            selectedDrawer == index ? const Color(0xffE1F5E9) : Colors.white,
        title: Text(
          _userOptions[index]["title"],
          style: TextStyle(
              fontFamily: FontConstants.medium,
              fontWeight: FontWeight.w500,
              color: selectedDrawer == index
                  ? const Color(0xff15582A)
                  : const Color(0xff969696)),
        ),
      );
}
