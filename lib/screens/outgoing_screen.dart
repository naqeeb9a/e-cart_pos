import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:pos/screens/drawer_screen.dart';
import 'package:pos/utils/constants/app_constants.dart';
import 'package:pos/utils/constants/font_constants.dart';
import 'package:pos/widgets/text_field.dart';
import 'package:pos/widgets/text_field_label.dart';

class OutgoingScreen extends StatefulWidget {
  const OutgoingScreen({Key? key}) : super(key: key);

  @override
  State<OutgoingScreen> createState() => _OutgoingScreenState();
}

class _OutgoingScreenState extends State<OutgoingScreen> {
  TextEditingController title = TextEditingController();
  TextEditingController quantity = TextEditingController();
  FocusNode titleNode = FocusNode();
  FocusNode quantityNode = FocusNode();
  final List<String> _stores = [
    "Jannat Cash and Carry Karachi",
    "Smart Faisalabad",
    "Proglabs Johar Town",
    "Danim Kareem Block",
    "Bilal Store Ravi Block Market"
  ];
  String? selectedStore;
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
          "Outgoing Stock",
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
              padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 20),
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
                  textFieldLabel(label: AppConstants.selectStore),
                  const SizedBox(height: 16),
                  DropdownButton2(
                    isExpanded: true,
                    underline: const Text(""),
                    hint: const Text(
                      AppConstants.selectStore,
                      style: TextStyle(
                          color: Color(0xffBCBCBC),
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          fontFamily: FontConstants.medium),
                      overflow: TextOverflow.ellipsis,
                    ),
                    items: _stores
                        .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontFamily: FontConstants.medium,
                          color: Colors.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ))
                        .toList(),
                    value: selectedStore,
                    onChanged: (value) {
                      setState(() {
                        selectedStore = value as String;
                      });
                    },
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                    ),
                    buttonHeight: 58,
                    buttonPadding: const EdgeInsets.only(left: 0, right: 14),
                    buttonDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xffEAEAEA)),
                      color: Colors.white,
                    ),
                    itemHeight: 40,
                    itemPadding: const EdgeInsets.only(left: 14, right: 14),
                    dropdownMaxHeight: 200,
                    dropdownPadding: null,
                    dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    dropdownElevation: 3,
                    scrollbarRadius: const Radius.circular(40),
                    scrollbarThickness: 6,
                    scrollbarAlwaysShow: true,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                      onPressed: () {},
                      child: const Text(
                        "Add to Outgoing Stock",
                        style: TextStyle(
                            fontFamily: FontConstants.medium,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ))
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.15),
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
}
