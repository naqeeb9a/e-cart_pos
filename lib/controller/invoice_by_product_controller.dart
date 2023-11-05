import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pos/controller/login_controller.dart';
import 'package:pos/model/invoice_by_product_model.dart';
import 'package:pos/utils/utills.dart';

class InvoiceByProductController extends GetxController {
  // final List items = [];
  bool loading = false;
  InvoicesByProductsModel? invoicesByProductsModel;
  setLoading() {
    loading = !loading;
    update();
  }

  reset() {
    invoicesByProductsModel = null;
    update();
  }

  Future<bool> getinvoicesByProducts(
    Map<String, dynamic> body,
  ) async {
    LoginController loginController = Get.find();
    setLoading();
    return await http.post(Uri.parse("$baseUrl/api/invoice"),
        body: jsonEncode(body),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization":
              "Bearer ${loginController.loginModel?.tokens?.accessToken}"
        }).then((response) {
      if (response.statusCode == 200) {
        invoicesByProductsModel =
            invoicesByProductsModelFromJson(response.body);
        // items.addAll(invoicesByProductsModel?.bill?.items ?? []);
        setLoading();
        return true;
      } else {
        Fluttertoast.showToast(msg: "unable to fetch invoice");
        setLoading();
        return false;
      }
    });
  }
}
