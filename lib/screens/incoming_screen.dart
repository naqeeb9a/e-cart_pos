import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/controller/add_incoming_stock.dart';
import 'package:pos/screens/Tabbar/tab_bar_screen.dart';
import 'package:pos/utils/constants/app_constants.dart';
import 'package:pos/utils/constants/font_constants.dart';
import 'package:pos/widgets/text_field.dart';

import '../model/add_incoming_stock_model.dart';

class IncomingScreen extends StatefulWidget {
  const IncomingScreen({Key? key}) : super(key: key);

  @override
  State<IncomingScreen> createState() => _IncomingScreenState();
}

class _IncomingScreenState extends State<IncomingScreen> {
  TextEditingController title = TextEditingController();
  TextEditingController quantity = TextEditingController();
  FocusNode titleNode = FocusNode();
  FocusNode quantityNode = FocusNode();

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
              scaffoldKey.currentState?.openDrawer();
            },
            icon: Image.asset(
              "images/drawer_icon.png",
              scale: 3,
            )),
        elevation: 0,
        title: const Text(
          "Incoming Stock",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: FontConstants.bold,
              color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            decoration: BoxDecoration(
                color: const Color(0xffEAF4DF),
                borderRadius: BorderRadius.circular(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Row(
                  children: [
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
                      Get.find<AddIncomingStockController>().addIncomingStock({
                        "products": [
                          {
                            "code_or_title": title.text,
                            "quantity": quantity.text
                          }
                        ]
                      });
                    },
                    child: const Text(
                      "Add to Incoming Stock",
                      style: TextStyle(
                          fontFamily: FontConstants.medium,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ))
              ],
            ),
          ),
          Expanded(
            child: GetBuilder<AddIncomingStockController>(
              builder: (addIncomingStockController) {
                if (addIncomingStockController.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (addIncomingStockController.addIncomingStockModel == null) {
                  return Center(
                    child: Image.asset(
                      "images/sacn_image.png",
                      scale: 3,
                    ),
                  );
                }
                return ListView.separated(
                  itemCount: addIncomingStockController
                          .addIncomingStockModel?.productsArray?.length ??
                      0,
                  separatorBuilder: (_, int index) =>
                      const SizedBox(height: 16),
                  itemBuilder: (_, int index) {
                    ProductsArray? productsArray = addIncomingStockController
                        .addIncomingStockModel?.productsArray?[index];
                    return Container(
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
                                    Text(
                                      "x ${productsArray?.quantity}",
                                      style: const TextStyle(
                                        color: Color(0xff969696),
                                        fontWeight: FontWeight.w500,
                                        fontFamily: FontConstants.medium,
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    Text(
                                      "\$ 122",
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: FontConstants.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 13),
                                Text(
                                  productsArray?.name ?? "",
                                  maxLines: 1,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      overflow: TextOverflow.ellipsis,
                                      fontFamily: FontConstants.medium,
                                      color: Color(0xff1B7575)),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  "ID # ${productsArray?.productsArrayId}",
                                  style: const TextStyle(
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
                    );
                  },
                );
              },
            ),
          ),
        ],
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
                        Get.find<AddIncomingStockController>().reset();
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
}
