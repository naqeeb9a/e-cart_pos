import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pos/controller/login_controller.dart';
import 'package:pos/model/add_outgoing_stock_model.dart';
import 'package:pos/utils/utills.dart';

class AddOutgoingStockController extends GetxController {
  bool loading = false;
  AddOutgoingStockModel? addOutgoingStockModel;
  setLoading() {
    loading = !loading;
    update();
  }

  Future<bool> addOutgoingStock(Object? body) async {
    LoginController loginController = Get.find();
    setLoading();
    return await http.post(Uri.parse("$baseUrl/api/invoice/outgoing"),
        body: jsonEncode(body),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization":
              "Bearer ${loginController.loginModel?.tokens?.accessToken}"
        }).then((response) {
      if (response.statusCode == 200) {
        addOutgoingStockModel = addOutgoingStockModelFromJson(response.body);
        Fluttertoast.showToast(msg: "success");
        setLoading();
        return true;
      } else {
        Fluttertoast.showToast(msg: "unable to add outgoing stock");
        setLoading();
        return false;
      }
    });
  }
}
