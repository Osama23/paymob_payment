import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paymob_payment/modules/payment/cubit/cubit.dart';
import 'package:paymob_payment/modules/payment/cubit/state.dart';
import 'package:paymob_payment/modules/payment/toggle.dart';
import 'package:paymob_payment/shared/components/components.dart';
import 'package:paymob_payment/styles/colors.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var emailNameController = TextEditingController();
  var phoneNameController = TextEditingController();
  var priceNameController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PaymentCubit(),
      child: BlocConsumer<PaymentCubit, PaymentStates>(
        listener: (context, state) {
          // if(state is PaymentRequestTokenCardSuccessState) {
          //
          // }
          if(state is PaymentReferenceCodeSuccessState || state is PaymentRequestTokenCardSuccessState){
            navigateAndFinish(context, ToggleScreen());
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              appBar: AppBar(
                backgroundColor: defColor,
                title: const Text("Paymob Payment"),
                centerTitle: true,
                elevation: 0,
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        defaultFormField(
                            controller: firstNameController,
                            type: TextInputType.name,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return "Please enter your first name";
                              }
                              return null;
                            },
                            label: "First Name",
                            prefix: Icons.person),
                        const SizedBox(
                          height: 20,
                        ),
                        // last name
                        defaultFormField(
                            controller: lastNameController,
                            type: TextInputType.name,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return "Please enter your last name";
                              }
                              return null;
                            },
                            label: "Last Name",
                            prefix: Icons.person),
                        const SizedBox(
                          height: 20,
                        ),
                        // email
                        defaultFormField(
                            controller: emailNameController,
                            type: TextInputType.emailAddress,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return "Please enter your email";
                              }
                              return null;
                            },
                            label: "Email",
                            prefix: Icons.email),
                        const SizedBox(
                          height: 20,
                        ),
                        // phone
                        defaultFormField(
                            controller: phoneNameController,
                            type: TextInputType.phone,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return "Please enter your phone number";
                              }
                              return null;
                            },
                            label: "Phone",
                            prefix: Icons.phone),
                        const SizedBox(
                          height: 20,
                        ),
                        // price
                        defaultFormField(
                            controller: priceNameController,
                            type: TextInputType.number,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return "Please enter price";
                              }
                              return null;
                            },
                            label: "Price",
                            prefix: Icons.price_check),
                        const SizedBox(
                          height: 20,
                        ),
                        defaultButton(
                          function: () async {
                            if (formKey.currentState!.validate()) {
                              await PaymentCubit.get(context).getFirstToken(
                                firstName: firstNameController.text,
                                lastName: lastNameController.text,
                                email: emailNameController.text,
                                phone: phoneNameController.text,
                                price: priceNameController.text,
                              );
                            }
                          },
                          text: "Go to Pay",
                          radius: 12,
                          width: 250,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
