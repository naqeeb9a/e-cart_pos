import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pos/controller/login_controller.dart';
import 'package:pos/model/add_incoming_stock_model.dart';
import 'package:pos/utils/utills.dart';

class AddIncomingStockController extends GetxController {
  bool loading = false;
  AddIncomingStockModel? addIncomingStockModel;
  setLoading() {
    loading = !loading;
    update();
  }

  reset() {
    addIncomingStockModel = null;
    update();
  }

  Future<bool> addIncomingStock(Object? body) async {
    LoginController loginController = Get.find();
    setLoading();
    return await http.post(Uri.parse("$baseUrl/api/invoice/incoming"),
        body: jsonEncode(body),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization":
              "Bearer ${loginController.loginModel?.tokens?.accessToken}"
        }).then((response) {
      if (response.statusCode == 200) {
        addIncomingStockModel = addIncomingStockModelFromJson(response.body);

        setLoading();
        return true;
      } else {
        Fluttertoast.showToast(msg: "unable to login");
        setLoading();
        return false;
      }
    });
  }
}
