
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/state_manager.dart';
import 'package:http/http.dart' as http;

import '../model/messages_model.dart';

class MessageController extends GetxController {
  MessagesModel? messagesModel;
  bool loading = false;
  setLoading() {
    loading = !loading;
    update();
  }

  addNewMessage(Map<String, dynamic> json) {
    messagesModel?.messages?.insert(0, Message.fromJson(json));
    update();
  }

  getMessages(String id, String accessToken, String chatToken) async {
    setLoading();
    await http.get(Uri.parse("http://34.254.211.149:3000/messages/$id"),
        headers: {
          "authorization": "Bearer $accessToken",
          "chat_token": chatToken
        }).then((value) {
      if (value.statusCode == 200) {
        messagesModel = messagesModelFromJson(value.body);
        setLoading();
      } else {
        Fluttertoast.showToast(msg: "unable to get messages");
        setLoading();
      }
    });
  }
}
