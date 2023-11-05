import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as socket_io_client;

import '../controller/login_controller.dart';
import '../controller/message_controller.dart';
import '../controller/threads_controller.dart';
import '../utils/constants/app_constants.dart';
import '../utils/constants/font_constants.dart';
import '../widgets/text_field.dart';
import 'Tabbar/tab_bar_screen.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({Key? key}) : super(key: key);

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  TextEditingController sendMessageController = TextEditingController();
  FocusNode messageNode = FocusNode();
  late socket_io_client.Socket socket;
  LoginController loginController = Get.find();
  ThreadsController threadsController = Get.find();
  MessageController messageController = Get.find();
  @override
  void initState() {
    connect();
    super.initState();
  }

  void connect() {
    threadsController
        .getThreads(loginController.loginModel?.user?.chatToken ?? "")
        .then((value) {
      if (value == true) {
        messageController.getMessages(
            threadsController.threadsModel?.first.id.toString() ?? "",
            loginController.loginModel?.tokens?.accessToken ?? "",
            loginController.loginModel?.user?.chatToken ?? "");
      }
    });
    socket = socket_io_client.io(
        "http://34.254.211.149:3000?chat_token=${loginController.loginModel?.user?.chatToken}",
        {
          "transports": ["websocket"],
          "autoconnect": false
        });
    socket.connect();
    socket.onConnect((data) {
      socket.on("message", (data) {
        messageController.addNewMessage(data);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        leading: IconButton(
            onPressed: () {
              scaffoldKey.currentState?.openDrawer();
            },
            icon: Image.asset(
              "images/drawer_icon.png",
              scale: 3,
            )),
        automaticallyImplyLeading: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Admin Support",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: FontConstants.bold,
              color: Colors.black),
        ),
      ),
      body: buildListView(),
    );
  }

  Widget buildListView() {
    return GetBuilder<ThreadsController>(
      builder: (threadsController) {
        if (threadsController.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (threadsController.threadsModel != null) {
          return GetBuilder<MessageController>(
            builder: (messageController) {
              if (messageController.loading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (messageController.messagesModel != null) {
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 5),
                        reverse: true,
                        itemCount:
                            messageController.messagesModel?.messages?.length ??
                                0,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            crossAxisAlignment: messageController.messagesModel
                                        ?.messages?[index].sender !=
                                    loginController.loginModel?.user?.id
                                ? CrossAxisAlignment.start
                                : CrossAxisAlignment.end,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                width: MediaQuery.of(context).size.width * 0.8,
                                decoration: BoxDecoration(
                                    color: messageController.messagesModel
                                                ?.messages?[index].sender !=
                                            loginController.loginModel?.user?.id
                                        ? Colors.yellow.shade100
                                        : Colors.green.shade100,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Text(messageController.messagesModel
                                        ?.messages?[index].message ??
                                    ""),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    _buildBottom(),
                  ],
                );
              }
              return Container();
            },
          );
        }
        return Container();
      },
    );
  }

  Container _buildBottom() {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
              child: textField(
            textInputAction: TextInputAction.done,
            hintText: AppConstants.typeMessage,
            controller: sendMessageController,
            focusNode: messageNode,
            isCode: true,
            isSearch: true,
          )),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                )),
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 14.5)),
            onPressed: () {
              socket.emit("send-message", {
                "reciever": "653571cdfa11c88f0f287abe",
                "sender": loginController.loginModel?.user?.id,
                "fcm_token": "",
                "message": sendMessageController.text,
                "thread": {}
              });
              messageController.addNewMessage({
                "reciever": "653571cdfa11c88f0f287abe",
                "sender": loginController.loginModel?.user?.id,
                "fcm_token": "",
                "message": sendMessageController.text,
                "thread": {}
              });
              sendMessageController.clear();
            },
            child: const Text(
              AppConstants.send,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontFamily: FontConstants.medium,
                fontSize: 16,
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    socket.close();
    super.dispose();
  }
}
