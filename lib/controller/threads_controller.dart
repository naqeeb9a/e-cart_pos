import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../model/threads_model.dart';

class ThreadsController extends GetxController {
  List<ThreadsModel>? threadsModel;
  bool loading = false;
  setLoading() {
    loading = !loading;
    update();
  }

  Future<bool> getThreads(String chatToken) async {
    setLoading();
    return await http.get(Uri.parse("http://34.254.211.149:3000/threads"),
        headers: {"chat_token": chatToken}).then((response) {
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        threadsModel = threadsModelFromJson(response.body);
        setLoading();
        return true;
      } else {
        Fluttertoast.showToast(msg: "unable to get thread");
        setLoading();
        return false;
      }
    });
  }
}
