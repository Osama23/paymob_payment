import 'package:flutter/material.dart';
import 'package:paymob_payment/modules/payment/refcode.dart';
import 'package:paymob_payment/modules/payment/visacard.dart';
import 'package:paymob_payment/shared/components/components.dart';
import 'package:paymob_payment/styles/colors.dart';

class ToggleScreen extends StatelessWidget {
  const ToggleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.center,
             mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    navigateAndFinish(context, const VisaCardScreen());
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: defColor),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Image(image: AssetImage('assets/images/card.png')),
                        SizedBox(height: 20,),
                        Text(
                          "Payment with card",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30,),
              Expanded(
                child: InkWell(
                  onTap: () {
                    navigateAndFinish(context, const RefCodeScreen());
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: defColor),
                    ),
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Image(image: AssetImage('assets/images/ref.jpeg')),
                        SizedBox(height: 20,),
                        Text("Payment with ref code",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
