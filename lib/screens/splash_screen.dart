import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/screens/Auth/signin_screen.dart';

import '../controller/login_controller.dart';
import '../controller/profile controller/profile_controller.dart';
import '../model/login_model.dart';
import '../utils/global.dart';
import 'Tabbar/tab_bar_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 1)).then((value) {
      String? user = Global.storageService.getAuthenticationModelString();
      if (user == null) {
        return Get.off(() => const SignInScreen());
      }
      LoginController loginController = Get.find();
      loginController.setLoginModel(loginModelFromJson(user));
      Get.find<LoadProfileController>()
          .getProfile(
              context, loginController.loginModel?.tokens?.accessToken ?? "")
          .then((value) {
        if (value == true) {
          return Get.off(() => const DrawerScreen());
        } else {
          return Get.off(() => const SignInScreen());
        }
      });
    });
    return Scaffold(
      backgroundColor: const Color(0xffF9B820),
      body: Center(
          child: Image.asset(
        "images/logo.png",
        scale: 3,
      )),
    );
  }
}
