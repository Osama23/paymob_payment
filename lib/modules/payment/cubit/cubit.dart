import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paymob_payment/models/first_token.dart';
import 'package:paymob_payment/modules/payment/cubit/state.dart';
import 'package:paymob_payment/shared/components/constants.dart';
import 'package:paymob_payment/shared/network/dio.dart';

class PaymentCubit extends Cubit<PaymentStates> {
  PaymentCubit() : super(PaymentInitialState());

  static PaymentCubit get(context) => BlocProvider.of(context);

  FirstToken? firstToken;

  Future getFirstToken(
      {required String price,
      required String firstName,
      required String lastName,
      required String email,
      required String phone}) async {
    await DioHelperPayment.postData(
      url: "auth/tokens",
      data: {'api_key': paymobApiKey},
    ).then((value) async {
      print("First token ${value.data["token"]}");
      // firstToken = FirstToken.fromJson(json.decode(value.data));
      //  firstToken = FirstToken.fromJson(value.data);
      paymobFirstToken = value.data["token"];
      print("paymobFirstToken $paymobFirstToken");
      await getOrderId(
          price: price,
          email: email,
          phone: phone,
          firstName: firstName,
          lastName: lastName);
      emit(PaymentSuccessState());
    }).catchError((error) {
      emit(PaymentFailureState(error));
    });
  }

  Future getOrderId(
      {required String price,
      required String firstName,
      required String lastName,
      required String email,
      required String phone}) async {
    await DioHelperPayment.postData(
      url: "ecommerce/orders",
      data: {
        'auth_token': paymobFirstToken,
        'delivery_needed': false,
        "amount_cents": price, //  "100",
        "currency": "EGP",
        "terminal_id": 23772,
        "merchant_order_id": 50026,
        "items": [],
      },
    ).then((value) async{
      print("order id ${value.data["id"].toString()}");
      // firstToken = FirstToken.fromJson(json.decode(value.data));
      //  firstToken = FirstToken.fromJson(value.data);
      paymobOrderId = value.data["id"].toString();
      await getFinalTokenCard(
          price: price,
          email: email,
          phone: phone,
          firstName: firstName,
          lastName: lastName);
      print("order id $paymobOrderId");
      await getFinalTokenKisok(
          price: price,
          email: email,
          phone: phone,
          firstName: firstName,
          lastName: lastName);
      print("order id $paymobOrderId");
      emit(PaymentOrderIdSuccessState());
    }).catchError((error) {
      emit(PaymentOrderIdFailureState(error));
    });
  }

  Future getFinalTokenCard(
      {required String price,
      required String firstName,
      required String lastName,
      required String email,
      required String phone}) async {
    await DioHelperPayment.postData(
      url: "acceptance/payment_keys",
      data: {
        'auth_token': paymobFirstToken,
        "order_id": paymobOrderId,
        "expiration": 3600,
        "amount_cents": price, //  "100",
        "billing_data": {
          "apartment": "803",
          "email": email, // "osama.abdelaziz23@gmail.com",
          "floor": "42",
          "first_name": firstName, // "Osama",
          "street": "Omar bn Elhattab",
          "building": "8028",
          "phone_number": phone, // "+201152597274",
          "shipping_method": "PKG",
          "postal_code": "6674",
          "city": "Al Ibrahymia",
          "country": "EG",
          "last_name": lastName, // "Abdelaziz",
          "state": "Sharqia"
        },
        "currency": "EGP",
        "integration_id": integrationIdCard, // your card id
        "lock_order_when_paid": "false"
      },
    ).then((value) {
      print("fianl token ${value.data["token"].toString()}");
      // firstToken = FirstToken.fromJson(json.decode(value.data));
      //  firstToken = FirstToken.fromJson(value.data);
      paymobFinalTokenCard = value.data["token"].toString();
      print("paymobFinalTokenCard  $paymobFinalTokenCard");
      emit(PaymentRequestTokenCardSuccessState());
    }).catchError((error) {
      emit(PaymentRequestTokenCardFailureState(error));
    });
  }

  Future getFinalTokenKisok(
      {required String price,
        required String firstName,
        required String lastName,
        required String email,
        required String phone}) async {
    await DioHelperPayment.postData(
      url: "acceptance/payment_keys",
      data: {
        'auth_token': paymobFirstToken,
        "order_id": paymobOrderId,
        "expiration": 3600,
        "amount_cents": price, //  "100",
        "billing_data": {
          "apartment": "803",
          "email": email, // "osama.abdelaziz23@gmail.com",
          "floor": "42",
          "first_name": firstName, // "Osama",
          "street": "Omar bn Elhattab",
          "building": "8028",
          "phone_number": phone, // "+201152597274",
          "shipping_method": "PKG",
          "postal_code": "6674",
          "city": "Al Ibrahymia",
          "country": "EG",
          "last_name": lastName, // "Abdelaziz",
          "state": "Sharqia"
        },
        "currency": "EGP",
        "integration_id": integrationIdKisok, // your card id
        "lock_order_when_paid": "false"
      },
    ).then((value) async{
      print("fianl token ${value.data["token"].toString()}");
      // firstToken = FirstToken.fromJson(json.decode(value.data));
      //  firstToken = FirstToken.fromJson(value.data);
      paymobFinalTokenKisok = value.data["token"].toString();
      print("paymobFinalTokenKisok  $paymobFinalTokenKisok");
      await getReferenceCode();
      emit(PaymentRequestTokenKioskSuccessState());
    }).catchError((error) {
      emit(PaymentRequestTokenKioskFailureState(error));
    });
  }

  Future getReferenceCode() async {
    await DioHelperPayment.postData(
      url: "acceptance/payments/pay",
      data: {
        'payment_token': paymobFinalTokenKisok,
        "source": {
          "identifier": "AGGREGATOR",
          "subtype": "AGGREGATOR"
        },
      },
    ).then((value) {
      print("ref code ${value.data["id"].toString()}");
      // firstToken = FirstToken.fromJson(json.decode(value.data));
      //  firstToken = FirstToken.fromJson(value.data);
      refCode = value.data["id"].toString();
      print("ref ode  $refCode");
      emit(PaymentReferenceCodeSuccessState());
    }).catchError((error) {
      emit(PaymentReferenceCodeFailureState(error));
    });
  }

}
