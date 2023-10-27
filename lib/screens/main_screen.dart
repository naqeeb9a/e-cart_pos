import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pos/screens/incoming_screen.dart';
import 'package:pos/screens/outgoing_screen.dart';
import 'package:pos/screens/return_screen.dart';
import 'package:pos/screens/sale_screen.dart';
import 'package:pos/utils/constants/app_constants.dart';

import '../utils/constants/font_constants.dart';

final StreamController<int> streamController =
    StreamController<int>.broadcast();

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List _tabs = [];
  late StreamSubscription<int> streamSubscription;
  @override
  void initState() {
    streamSubscription = streamController.stream.listen((value) {
      controller!.jumpToPage(value);
      currentTab = value;
      if (mounted) setState(() {});
    });

    _tabs = [
      {"icon": "sale", "title": AppConstants.sale},
      {"icon": "return", "title": AppConstants.returnText},
      {"icon": "incoming", "title": AppConstants.incoming},
      {"icon": "outgoing", "title": AppConstants.outgoing},
    ];
    controller = PageController(initialPage: currentTab);
    super.initState();
  }

  @override
  void dispose() {
    streamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: _bottomNavigationBar(),
      body: _buildBody(),
    );
  }

  PageController? controller;

  Widget _buildBody() {
    return PageView(
      controller: controller,
      physics: const NeverScrollableScrollPhysics(),
      children: const [
        SaleScreen(),
        ReturnScreen(),
        IncomingScreen(),
        OutgoingScreen(),
      ],
    );
  }

  Color selectedTabIconColor = const Color(0xff1B7575);
  Color unSelectedTabIconColor = const Color(0xff5C1F5A);
  Color unSelectedTabTextColor = const Color(0xff969696);
  Color tabBackColor = const Color(0xffE1F5E9);
  int currentTab = 0;

  Widget _bottomNavigationBar() => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
                  4,
                  (index) =>
                      Expanded(child: _buildBottomItem(_tabs[index], index)))
              .toList(),
        ),
      );

  Widget _buildBottomItem(tabData, index) => ElevatedButton(
      onPressed: () {
        controller!.jumpToPage(index);
        if (mounted) {
          setState(() {});
          currentTab = index;
        }
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: currentTab == index ? tabBackColor : Colors.white,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(vertical: 13)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            "images/${tabData["icon"]}_icon.png",
            scale: 3,
            color: currentTab == index
                ? selectedTabIconColor
                : unSelectedTabIconColor,
          ),
          const SizedBox(height: 8),
          Text(
            tabData["title"],
            style: TextStyle(
                color: currentTab == index
                    ? selectedTabIconColor
                    : unSelectedTabTextColor,
                fontWeight: FontWeight.w600,
                fontFamily: FontConstants.bold),
          ),
        ],
      ));
}
