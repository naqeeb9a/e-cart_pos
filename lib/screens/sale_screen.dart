import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:pos/controller/create_invoice_controller.dart';
import 'package:pos/controller/invoice_by_product_controller.dart';
import 'package:pos/screens/Tabbar/tab_bar_screen.dart';
import 'package:pos/screens/checkout_screen.dart';
import 'package:pos/utils/constants/app_constants.dart';
import 'package:pos/utils/constants/font_constants.dart';
import 'package:pos/widgets/checkout_bottom.dart';
import 'package:pos/widgets/text_field.dart';

import '../model/invoice_by_product_model.dart';

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
              scaffoldKey.currentState?.openDrawer();
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
                      InvoiceByProductController invoiceByProductController =
                          Get.find();
                      Map<String, dynamic> body = {
                        "products": [
                          {
                            "code_or_title": title.text,
                            "quantity": int.parse(quantity.text)
                          }
                        ],
                        "description": "Testing Please Ignore"
                      };
                      invoiceByProductController.getinvoicesByProducts(body);
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
          Expanded(
            child: GetBuilder<InvoiceByProductController>(
                builder: (invoiceByProductController) {
              if (invoiceByProductController.loading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (invoiceByProductController.invoicesByProductsModel != null) {
                return ListView.separated(
                  primary: false,
                  itemCount: invoiceByProductController
                          .invoicesByProductsModel?.bill?.items?.length ??
                      0,
                  separatorBuilder: (_, int index) =>
                      const SizedBox(height: 16),
                  itemBuilder: (_, int index) {
                    InvoiceItem? item = invoiceByProductController
                        .invoicesByProductsModel?.bill?.items?[index];
                    Future.delayed(
                        600.milliseconds,
                        () => bottomSheet(invoiceByProductController
                            .invoicesByProductsModel));
                    return InkWell(
                      onTap: () {
                        bottomSheet(
                            invoiceByProductController.invoicesByProductsModel);
                      },
                      child: Container(
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
                                child: FadeInImage(
                                  placeholder:
                                      const AssetImage("images/logo_e.png"),
                                  image: NetworkImage(
                                      item?.images?.first.mobile ?? ""),
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
                                      Text(
                                        "\$ ${item?.price}",
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: FontConstants.bold,
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        "x ${item?.quantity}",
                                        style: const TextStyle(
                                          color: Color(0xff969696),
                                          fontWeight: FontWeight.w500,
                                          fontFamily: FontConstants.medium,
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                      Text(
                                        "\$ ${(item?.price ?? 0) * (item?.quantity ?? 0)}",
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
                                    item?.name ?? "",
                                    maxLines: 1,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        overflow: TextOverflow.ellipsis,
                                        fontFamily: FontConstants.medium,
                                        color: Color(0xff1B7575)),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    "ID # ${item?.id}",
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
                      ),
                    );
                  },
                );
              }
              return InkWell(
                onTap: () async {
                  String barcodeScanRes =
                      await FlutterBarcodeScanner.scanBarcode(
                          "#000000", "cancel", true, ScanMode.BARCODE);
                  if (kDebugMode) {
                    print(barcodeScanRes);
                  }
                },
                child: Image.asset(
                  "images/sacn_image.png",
                  scale: 3,
                ),
              );
            }),
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
                        Get.find<InvoiceByProductController>().reset();
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

  bottomSheet(InvoicesByProductsModel? invoicesByProductsModel) {
    Get.bottomSheet(
        isDismissible: false,
        CheckOutBottomSheet(
          onButtonPressed: () {
            Get.find<CreateInvoiceController>().createInvoice({
              "products": [
                {
                  "code_or_title":
                      invoicesByProductsModel?.bill?.items?.first.name,
                  "quantity":
                      invoicesByProductsModel?.bill?.items?.first.quantity,
                },
              ],
            }).then((value) {
              if (value == true) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => CheckOutScreen(
                            invoicesByProductsModel:
                                invoicesByProductsModel))).then((_) {
                  Navigator.pop(context);
                  Get.find<InvoiceByProductController>().reset();
                });
              }
            });
          },
          invoicesByProductsModel: invoicesByProductsModel,
        ),
        barrierColor: Colors.transparent);
  }
}
