import 'package:flutter/material.dart';
import 'package:pos/screens/Auth/signin_screen.dart';
import 'package:pos/utils/helping_method.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  bool visible = false;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1)).then((value) {
      setState(() {
        visible = !visible;
      });
      Future.delayed(const Duration(seconds: 2)).then((value) {
        HelpingMethods().openAndReplaceScreen(
            context: context, screen: const SignInScreen());
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF9B820),
      body: Center(
          child: AnimatedOpacity(
            opacity: visible ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 500),
            child: Image.asset(
              "images/logo.png",
              scale: 3,
            ),
          )),
    );
  }
}