import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pos/controller/login_controller.dart';
import 'package:pos/model/store_model.dart';
import 'package:pos/utils/utills.dart';

class StoreController extends GetxController {
  bool loading = false;
  StoreModel? storeModel;

  StoreController() {
    getStores();
  }

  setLoading() {
    loading = !loading;
    update();
  }

  Future<bool> getStores() async {
    LoginController loginController = Get.find();
    setLoading();
    return await http.get(Uri.parse("$baseUrl/api/store"), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization":
          "Bearer ${loginController.loginModel?.tokens?.accessToken}"
    }).then((response) {
      if (response.statusCode == 200) {
        storeModel = storeModelFromJson(response.body);

        setLoading();
        return true;
      } else {
        Fluttertoast.showToast(msg: "unable to get stores");
        setLoading();
        return false;
      }
    });
  }
}
