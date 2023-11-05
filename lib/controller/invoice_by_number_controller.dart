import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pos/controller/login_controller.dart';
import 'package:pos/model/invoice_by_number_model.dart';
import 'package:pos/utils/utills.dart';

class InvoiceByNumberController extends GetxController {
  bool loading = false;
  InvoiceByNumberModel? invoiceByNumberModel;
  setLoading() {
    loading = !loading;
    update();
  }

  reset() {
    invoiceByNumberModel = null;
    update();
  }

  Future<bool> getInvoiceByNumber(String? invoiceNumber) async {
    LoginController loginController = Get.find();
    setLoading();
    return await http
        .get(Uri.parse("$baseUrl/api/invoice/$invoiceNumber"), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization":
          "Bearer ${loginController.loginModel?.tokens?.accessToken}"
    }).then((response) {
      if (response.statusCode == 200) {
        invoiceByNumberModel = invoiceByNumberModelFromJson(response.body);

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
