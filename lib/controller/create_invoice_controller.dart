import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pos/controller/login_controller.dart';
import 'package:pos/model/create_invoice_model.dart';
import 'package:pos/utils/utills.dart';

class CreateInvoiceController extends GetxController {
  bool loading = false;
  CreateInvoiceModel? createInvoiceModel;
  setLoading() {
    loading = !loading;
    update();
  }

  Future<bool> createInvoice(
    Map<String, dynamic> body,
  ) async {
    LoginController loginController = Get.find();
    setLoading();
    return await http.post(Uri.parse("$baseUrl/api/invoice/create"),
        body: jsonEncode(body),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization":
              "Bearer ${loginController.loginModel?.tokens?.accessToken}"
        }).then((response) {
      if (response.statusCode == 200) {
        createInvoiceModel = createInvoiceModelFromJson(response.body);

        setLoading();
        return true;
      } else {
        Fluttertoast.showToast(msg: "unable to create invoic");
        setLoading();
        return false;
      }
    });
  }
}
