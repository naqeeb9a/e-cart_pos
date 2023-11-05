import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/state_manager.dart';
import 'package:http/http.dart' as http;
import 'package:pos/model/login_model.dart';
import 'package:pos/utils/utills.dart';

import '../utils/global.dart';

class LoginController extends GetxController {
  bool loading = false;
  LoginModel? loginModel;
  setLoading() {
    loading = !loading;
    update();
  }

  setLoginModel(LoginModel? updatedloginModel) {
    loginModel = updatedloginModel;
    update();
  }

  Future<bool> loginUser(String email, String password) async {
    setLoading();
    return await http.post(Uri.parse("$baseUrl/api/auth/login"),
        body: {"email": email, "password": password}).then((response) {
      if (response.statusCode == 200) {
        loginModel = loginModelFromJson(response.body);
        Global.storageService.setAuthenticationModelString(response.body);
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
