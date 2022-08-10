import 'package:flutter/material.dart';
import 'package:paymob_payment/modules/payment/refcode.dart';
import 'package:paymob_payment/modules/register/register.dart';
import 'package:paymob_payment/shared/network/dio.dart';

import 'modules/payment/toggle.dart';

void main() async{
  await DioHelperPayment.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const RegisterScreen(),
    );
  }
}
