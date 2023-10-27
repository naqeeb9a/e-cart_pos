import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/utils/constants/app_constants.dart';
import 'package:pos/utils/constants/font_constants.dart';

import '../model/invoice_by_product_model.dart';

class CheckOutBottomSheet extends StatefulWidget {
  final InvoicesByProductsModel? invoicesByProductsModel;
  final VoidCallback onButtonPressed;

  const CheckOutBottomSheet(
      {Key? key, required this.onButtonPressed, this.invoicesByProductsModel})
      : super(key: key);

  @override
  State<CheckOutBottomSheet> createState() => _CheckOutBottomSheetState();
}

class _CheckOutBottomSheetState extends State<CheckOutBottomSheet> {
  bool isEClan = false;

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
        children: [
          _buildCheckOutDetails(),
          ListTile(
            contentPadding: EdgeInsets.zero,
            trailing: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffF9B820),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10)),
              onPressed: widget.onButtonPressed,
              child: const Text(
                "Checkout",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Inter-Medium",
                  fontSize: 16,
                ),
              ),
            ),
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {},
                  padding: EdgeInsets.zero,
                  color: Theme.of(context).colorScheme.primary,
                  icon: const Icon(Icons.keyboard_arrow_up),
                ),
              ],
            ),
            title: RichText(
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
            subtitle: const Text(
              "\$482",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontFamily: "Inter-Bold",
                fontSize: 18,
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
              onPressed: () {
                Get.back();
              },
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
                _checkoutDetailHeading("Sub Total"),
                _checkoutDetailSubHeading(
                    "\$ ${widget.invoicesByProductsModel?.bill?.items?.forEach((element) {})}"),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _checkoutDetailHeading("Tax (17%)"),
                _checkoutDetailSubHeading(isEClan ? "\$12" : "Free",
                    color: const Color(0xffF9B820))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _checkoutDetailHeading("Discount Price"),
                _checkoutDetailSubHeading("\$12"),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 16, bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _checkoutDetailHeading("Is this user an eClan Member?"),
                GestureDetector(
                    onTap: () {
                      isEClan = !isEClan;
                      setState(() {});
                    },
                    child: Image.asset(
                      "images/yes_icon.png",
                      scale: 3,
                    )),
              ],
            ),
          ),
          if (isEClan)
            const Padding(
              padding: EdgeInsets.only(left: 6.0),
              child: Icon(
                CupertinoIcons.qrcode,
                size: 70,
              ),
            )
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
}
