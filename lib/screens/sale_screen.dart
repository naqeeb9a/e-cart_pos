import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:pos/screens/checkout_screen.dart';
import 'package:pos/screens/drawer_screen.dart';
import 'package:pos/utils/constants/app_constants.dart';
import 'package:pos/utils/constants/font_constants.dart';
import 'package:pos/widgets/checkout_bottom.dart';
import 'package:pos/widgets/text_field.dart';

class SaleScreen extends StatefulWidget {
  const SaleScreen({Key? key}) : super(key: key);

  @override
  State<SaleScreen> createState() => _SaleScreenState();
}

class _SaleScreenState extends State<SaleScreen> {
  TextEditingController title = TextEditingController();
  TextEditingController quantity = TextEditingController();
  FocusNode titleNode = FocusNode();
  FocusNode quantityNode = FocusNode();
  bool isAdded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          "Create Sale",
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
                  Row(
                    children: const [
                      Expanded(
                        child: Text(
                          "Product Title / Code",
                          style: TextStyle(
                              fontFamily: FontConstants.bold,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          "Quantity",
                          style: TextStyle(
                              fontFamily: FontConstants.bold,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: textField(
                          textInputAction: TextInputAction.next,
                          hintText: "e.g. 2713890",
                          controller: title,
                          focusNode: titleNode,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: textField(
                          textInputAction: TextInputAction.done,
                          hintText: "e.g. 2",
                          controller: quantity,
                          focusNode: quantityNode,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                      onPressed: () {
                        bottomSheet();
                        isAdded = true;
                        setState(() {});
                      },
                      child: const Text(
                        "Add to Invoice",
                        style: TextStyle(
                            fontFamily: FontConstants.medium,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ))
                ],
              ),
            ),
            if (isAdded) const SizedBox(height: 20),
            if (isAdded)
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
            if (!isAdded)
              SizedBox(height: MediaQuery.of(context).size.height * 0.15),
            if (!isAdded)
              Image.asset(
                "images/sacn_image.png",
                scale: 3,
              ),
          ],
        ),
      ),
    );
  }

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

  bottomSheet() {
    Get.bottomSheet(
        isDismissible:false,
      CheckOutBottomSheet(onButtonPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => const CheckOutScreen())).then((_) {
          isAdded = false;
          setState(() {});
        });
      }),
      barrierColor: Colors.transparent
    );
  }
}
