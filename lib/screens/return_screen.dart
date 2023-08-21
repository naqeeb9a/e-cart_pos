import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/screens/drawer_screen.dart';
import 'package:pos/utils/constants/app_constants.dart';
import 'package:pos/utils/constants/font_constants.dart';
import 'package:pos/widgets/return_bottom.dart';
import 'package:pos/widgets/text_field.dart';

class ReturnScreen extends StatefulWidget {
  const ReturnScreen({Key? key}) : super(key: key);

  @override
  State<ReturnScreen> createState() => _ReturnScreenState();
}

class _ReturnScreenState extends State<ReturnScreen> {
  TextEditingController invoice = TextEditingController();
  FocusNode invoiceNode = FocusNode();
  bool isFind = false;
  bool showReturnAmount = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              scaffoldKey.currentState!.openDrawer();
            },
            icon: Image.asset(
              "images/drawer_icon.png",
              scale: 3,
            )),
        elevation: 0,
        title: const Text(
          "Return",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: FontConstants.bold,
              color: Colors.black),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              decoration: BoxDecoration(
                  color: const Color(0xffEAF4DF),
                  borderRadius: BorderRadius.circular(16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Invoice No.",
                    style: TextStyle(
                        fontFamily: FontConstants.bold,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  const SizedBox(height: 16),
                  textField(
                    textInputAction: TextInputAction.next,
                    hintText: "e.g. 2713890",
                    controller: invoice,
                    focusNode: invoiceNode,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                      onPressed: () {
                        returnSheet();
                        showReturnAmount = true;
                        setState(() {});
                      },
                      child: const Text(
                        "Find",
                        style: TextStyle(
                            fontFamily: FontConstants.medium,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ))
                ],
              ),
            ),
            if (!showReturnAmount && !isFind)
              SizedBox(height: MediaQuery.of(context).size.height * 0.15),
            if (!showReturnAmount && !isFind)
              Image.asset(
                "images/sacn_image.png",
                scale: 3,
              ),
            if (isFind || showReturnAmount) const SizedBox(height: 20),
            if (isFind || showReturnAmount)
              ListView.separated(
                shrinkWrap: true,
                primary: false,
                itemCount: 1,
                separatorBuilder: (_, int index) => const SizedBox(height: 16),
                itemBuilder: (_, int index) => Container(
                  padding: const EdgeInsets.all(13),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: const Color(0xffF3F2F4),
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 90,
                        height: 74,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: const Color(0xffF3F2F4),
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: const FadeInImage(
                            placeholder: AssetImage("images/logo_e.png"),
                            image: NetworkImage(
                                "https://images.unsplash.com/photo-1564216329574-c839d4eedb1b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1272&q=80"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  "\$ 122",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: FontConstants.bold,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                const Text(
                                  "x 1",
                                  style: TextStyle(
                                    color: Color(0xff969696),
                                    fontWeight: FontWeight.w500,
                                    fontFamily: FontConstants.medium,
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Text(
                                  "\$ 122",
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: FontConstants.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 13),
                            const Text(
                              "MacBook Pro 13-in (M1,2020)",
                              maxLines: 1,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  overflow: TextOverflow.ellipsis,
                                  fontFamily: FontConstants.medium,
                                  color: Color(0xff1B7575)),
                            ),
                            const SizedBox(height: 2),
                            const Text(
                              "ID # 219387",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  fontFamily: FontConstants.medium,
                                  color: Color(0xff2C3630)),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 4),
                      IconButton(
                          onPressed: () {
                            _deleteDialog();
                          },
                          icon: Image.asset("images/delete_icon.png")),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget sheet() => Container(
        width: double.infinity,
        padding: const EdgeInsets.only(top: 30, right: 20, bottom: 30),
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
        child: ListTile(
          onTap: () {
            Get.back();
            summarySheet();
            showReturnAmount = false;
            isFind = true;
            setState(() {});
          },
          title: Text(
            "Return Amount",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: FontConstants.bold,
            ),
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: const TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: "Total",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Inter-SemiBold",
                      ),
                    ),
                    TextSpan(
                      text: "  Incl. Tax",
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xff969696),
                        fontWeight: FontWeight.w500,
                        fontFamily: "Inter-Medium",
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "\$482",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Inter-Bold",
                  fontSize: 18,
                ),
              )
            ],
          ),
        ),
      );

  _deleteDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  "images/remove_product.png",
                  scale: 3,
                ),
                const SizedBox(height: 16),
                const Text(
                  AppConstants.areSure,
                  style: TextStyle(
                      fontSize: 18,
                      color: Color(0xff1B7575),
                      fontFamily: FontConstants.bold,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  AppConstants.areSureproductDesc,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xff969696),
                      fontFamily: FontConstants.medium,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                        child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Colors.white,
                        side: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                            width: 2),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        AppConstants.cancel,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: FontConstants.bold,
                        ),
                      ),
                    )),
                    const SizedBox(width: 20),
                    Expanded(
                        child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        AppConstants.yes,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: FontConstants.bold,
                        ),
                      ),
                    ))
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  returnSheet(){
    Get.bottomSheet(
        isDismissible:false,
        sheet(),
        barrierColor: Colors.transparent
    );
  }

  summarySheet(){
    Get.bottomSheet(
        isScrollControlled:true,
        ReturnBottomSheet(
          onButtonPressed: () {
            isFind = false;
            showReturnAmount = false;
            Get.back();
            setState(() {});
          },
          onClose: () {
            Get.back();
            returnSheet();
            isFind = false;
            showReturnAmount = true;
            setState(() {});
          },
        ),
        barrierColor: Colors.transparent
    );
  }

}
