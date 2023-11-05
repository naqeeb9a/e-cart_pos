import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pos/controller/add_incoming_stock.dart';
import 'package:pos/controller/add_outgoing_stock.dart';
import 'package:pos/controller/create_invoice_controller.dart';
import 'package:pos/controller/invoice_by_number_controller.dart';
import 'package:pos/controller/invoice_by_product_controller.dart';
import 'package:pos/controller/login_controller.dart';
import 'package:pos/controller/message_controller.dart';
import 'package:pos/controller/profile%20controller/profile_controller.dart';
import 'package:pos/controller/stores_controller.dart';
import 'package:pos/controller/threads_controller.dart';
import 'package:pos/screens/splash_screen.dart';
import 'package:pos/utils/global.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  await Global.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
    Get.put(CreateInvoiceController());
    Get.put(InvoiceByProductController());
    Get.put(InvoiceByNumberController());
    Get.put(AddIncomingStockController());
    Get.put(AddOutgoingStockController());
    Get.put(StoreController());
    Get.put(LoadProfileController());
    Get.put(ThreadsController());
    Get.put(MessageController());
    return GetMaterialApp(
      title: 'ECart POS',
      theme: ThemeData(
          fontFamily: "TT Norms Pro",
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              //elevation of button
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.symmetric(
                  horizontal: 20, vertical: 16), //content padding inside button
            ),
          ),
          colorScheme: const ColorScheme(
            primary: Color(0xff76B139),
            secondary: Color(0xffF9B820),
            surface: Colors.white,
            background: Color(0xffF8FAF8),
            error: Colors.red,
            onPrimary: Colors.white,
            onSecondary: Colors.deepOrange,
            onSurface: Colors.black,
            onBackground: Colors.black,
            onError: Colors.redAccent,
            brightness: Brightness.light,
          )),
      home: const SplashScreen(),
    );
  }
}
