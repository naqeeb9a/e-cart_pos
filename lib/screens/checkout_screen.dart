import 'package:flutter/material.dart';
import 'package:pos/utils/constants/app_constants.dart';
import 'package:pos/utils/constants/font_constants.dart';

import '../model/invoice_by_product_model.dart';

class CheckOutScreen extends StatelessWidget {
  final InvoicesByProductsModel? invoicesByProductsModel;
  final bool isEClan;
  const CheckOutScreen(
      {Key? key, this.isEClan = true, this.invoicesByProductsModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 30),
              Center(
                  child: Image.asset(
                "images/done_icon.png",
                scale: 3,
              )),
              const SizedBox(height: 20),
              const Text(
                "Congratulations",
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                    fontFamily: FontConstants.bold,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              const Text(
                "Your payment has been made",
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontFamily: FontConstants.regular,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 40),
              const Text(
                AppConstants.billSummary,
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontFamily: FontConstants.bold,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _checkoutDetailHeading("Sub Total"),
                  _checkoutDetailSubHeading("\$482"),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _checkoutDetailHeading("Tax (17%)"),
                  _checkoutDetailSubHeading(isEClan ? "\$12" : "Free",
                      color: const Color(0xffF9B820))
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _checkoutDetailHeading("Discount Price"),
                  _checkoutDetailSubHeading("\$12"),
                ],
              ),
              const Spacer(),
              ListTile(
                contentPadding: EdgeInsets.zero,
                trailing: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffF9B820),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 10)),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Done",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Inter-Medium",
                      fontSize: 16,
                    ),
                  ),
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
        ),
      ),
    );
  }

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
