import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pos/utils/constants/app_constants.dart';
import 'package:pos/utils/constants/font_constants.dart';
import 'package:pos/widgets/text_field.dart';
import 'package:pos/widgets/text_field_label.dart';

class ReturnBottomSheet extends StatefulWidget {
  final VoidCallback onButtonPressed;
  final VoidCallback onClose;

  const ReturnBottomSheet({Key? key, required this.onButtonPressed, required this.onClose})
      : super(key: key);

  @override
  State<ReturnBottomSheet> createState() => _ReturnBottomSheetState();
}

class _ReturnBottomSheetState extends State<ReturnBottomSheet> {
  final List<String> _cats = ["Refund", "Exchange"];
  int selectedCat = 0;
  TextEditingController description = TextEditingController();
  FocusNode descriptionlNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 13, right: 20, bottom: 20),
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildCheckOutDetails(),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffF9B820),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 13)),
              onPressed: widget.onButtonPressed,
              child: const Text(
                "Save Data",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Inter-Medium",
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckOutDetails() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: const EdgeInsets.only(left: 16, right: 0),
            title: const Text(
              AppConstants.billSummary,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontFamily: "Inter-Bold",
              ),
            ),
            trailing: IconButton(
              onPressed: widget.onClose,
              icon: const Icon(
                Icons.cancel,
                color: Colors.black,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _checkoutDetailHeading("Amount Total"),
                _checkoutDetailSubHeading("\$482"),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _checkoutDetailHeading("Tax (17%)"),
                _checkoutDetailSubHeading("\$472",
                    color: const Color(0xffF9B820))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _checkoutDetailHeading("Sub Total"),
                _checkoutDetailSubHeading("\$12"),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _checkoutDetailHeading("Total Returnable"),
                _checkoutDetailSubHeading("\$482"),
              ],
            ),
          ),
          Row(
            children: List.generate(
                2,
                (index) => Expanded(
                      child: RadioListTile(
                          value: index,
                          activeColor: Theme.of(context).colorScheme.primary,
                          title: Transform.translate(
                              offset: const Offset(-10, 0),
                              child: Text(_cats[index])),
                          groupValue: selectedCat,
                          onChanged: (int? val) {
                            selectedCat = val!;
                            setState(() {});
                          }),
                    )),
          ),
          if (selectedCat == 1) buildExchange(),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: textFieldLabel(label: "Add Description"),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: textField(
              minLines: 4,
              textInputAction: TextInputAction.done,
              hintText: "Write a Description here",
              controller: description,
              focusNode: descriptionlNode,
            ),
          ),
        ],
      );

  Text _checkoutDetailHeading(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w400,
        fontFamily: FontConstants.regular,
      ),
    );
  }

  Text _checkoutDetailSubHeading(String title, {Color color = Colors.black}) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16,
        color: color,
        fontWeight: FontWeight.bold,
        fontFamily: FontConstants.bold,
      ),
    );
  }

  Widget buildExchange() => Column(
        children: [
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Row(
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
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: textField(
                    textInputAction: TextInputAction.next,
                    hintText: "e.g. 2713890",
                    controller: TextEditingController(),
                    focusNode: FocusNode(),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: textField(
                    textInputAction: TextInputAction.done,
                    hintText: "e.g. 2",
                    controller: TextEditingController(),
                    focusNode: FocusNode(),
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 8)),
                  child: Icon(Icons.add),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 16, bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Is this user an eClan Member?",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: FontConstants.bold,
                  ),
                ),
                GestureDetector(
                    onTap: () {},
                    child: Image.asset(
                      "images/yes_icon.png",
                      scale: 3,
                    )),
              ],
            ),
          ),
        ],
      );
}
