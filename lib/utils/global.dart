import 'package:flutter/cupertino.dart';

import '../controller/extras/storage_controller.dart';

class Global {
  static late StorageService storageService;
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    storageService = await StorageService().init();
  }
}
