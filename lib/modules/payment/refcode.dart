import 'package:flutter/material.dart';
import 'package:paymob_payment/shared/components/constants.dart';
import 'package:paymob_payment/styles/colors.dart';

class RefCodeScreen extends StatelessWidget {
  const RefCodeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "You should go to any market to pay",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "This is the reference code",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            Card(
              elevation: 12,
              shape: Border.all(color: defColor, width: 1),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  refCode,
                  style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
