import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pos/model/printer.dart';
import 'package:pos/screens/drawer_screen.dart';
import 'package:pos/utils/constants/app_constants.dart';
import 'package:pos/utils/constants/font_constants.dart';
import 'package:pos/widgets/text_field.dart';
import 'package:pos/widgets/text_field_label.dart';

class PrinterScreen extends StatefulWidget {
  const PrinterScreen({Key? key}) : super(key: key);

  @override
  State<PrinterScreen> createState() => _PrinterScreenState();
}

class _PrinterScreenState extends State<PrinterScreen> {
  final List<String> _printers = [
    "Bluetooth Printers",
    "Wifi Printers",
    "Wired Printer",
  ];
  TextEditingController printerName = TextEditingController();
  FocusNode printerNameNode = FocusNode();
  String? selectedPrinter;
  bool sowPrinter = false;
  List<PrinterModel> printerList = [];

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
          "Select Printer",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: FontConstants.bold,
              color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            textFieldLabel(label: AppConstants.printerType),
            const SizedBox(height: 16),
            DropdownButton2(
              isExpanded: true,
              underline: const Text(""),
              hint: const Text(
                AppConstants.printerTypeHint,
                style: TextStyle(
                    color: Color(0xffBCBCBC),
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    fontFamily: FontConstants.medium),
                overflow: TextOverflow.ellipsis,
              ),
              items: _printers
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
              value: selectedPrinter,
              onChanged: (value) {
                setState(() {
                  selectedPrinter = value as String;
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
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                sowPrinter = true;
                setState(() {});
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffEAF4DF),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              ),
              child: Text(
                "Find Printer",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold),
              ),
            ),
            if (sowPrinter) _printerDetail(),
            const SizedBox(height: 20),
            if (printerList.isNotEmpty)
              const Text(
                "Printers",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: FontConstants.bold,
                    fontSize: 18),
              ),
            if (printerList.isNotEmpty) const SizedBox(height: 16),
            if (printerList.isNotEmpty)
              ListView.separated(
                shrinkWrap: true,
                primary: false,
                itemCount: printerList.length,
                separatorBuilder: (_, int index) => const SizedBox(height: 16),
                itemBuilder: (_, int index) => Container(
                  padding: const EdgeInsets.all(13),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xffEAEAEA)),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              printerList[index].name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: FontConstants.bold,
                                  fontSize: 18),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              printerList[index].type,
                              style: const TextStyle(
                                  fontFamily: FontConstants.medium,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff1B7575)),
                            ),
                             Text(
                              "Model: ${printerList[index].model}",
                              style: const TextStyle(
                                  fontFamily: FontConstants.medium,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff1B7575)),
                            ),
                             Text(
                              "Identifier: ${printerList[index].identifier}",
                              style: const TextStyle(
                                  fontFamily: FontConstants.medium,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff1B7575)),
                            ),
                          ],
                        ),
                      ),
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

  Widget _printerDetail() => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 20),
          const Text(
            "Bluetooth Printer",
            style: TextStyle(
                fontFamily: FontConstants.medium,
                fontWeight: FontWeight.w500,
                color: Color(0xff1B7575)),
          ),
          const Text(
            "BModel: DW-78219",
            style: TextStyle(
                fontFamily: FontConstants.medium,
                fontWeight: FontWeight.w500,
                color: Color(0xff1B7575)),
          ),
          const Text(
            "Identifier: 74:F0:J7:D5:E7:R2",
            style: TextStyle(
                fontFamily: FontConstants.medium,
                fontWeight: FontWeight.w500,
                color: Color(0xff1B7575)),
          ),
          const SizedBox(height: 20),
          textFieldLabel(label: AppConstants.printerName),
          const SizedBox(height: 16),
          textField(
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.name,
            hintText: AppConstants.printerNameHint,
            controller: printerName,
            focusNode: printerNameNode,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp('[a-z A-Z]'))
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              sowPrinter = false;
              printerList.add(PrinterModel(
                  name: "Alias Printer",
                  type: "Bluetooth Printer",
                  model: "DW-78219",
                  identifier: "74:F0:J7:D5:E7:R2"));
              setState(() {});
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            ),
            child: const Text(
              "Save",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
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
                  AppConstants.areSureDesc,
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
