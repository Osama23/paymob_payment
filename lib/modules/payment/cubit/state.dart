abstract class PaymentStates{}


class PaymentInitialState extends PaymentStates{

}


class PaymentSuccessState extends PaymentStates{

}

class PaymentFailureState extends PaymentStates{
  String error;

  PaymentFailureState(this.error);
}

class PaymentOrderIdSuccessState extends PaymentStates{

}

class PaymentOrderIdFailureState extends PaymentStates{
  String error;

  PaymentOrderIdFailureState(this.error);
}

class PaymentRequestTokenCardSuccessState extends PaymentStates{

}

class PaymentRequestTokenCardFailureState extends PaymentStates{
  String error;

  PaymentRequestTokenCardFailureState(this.error);
}

class PaymentRequestTokenKioskSuccessState extends PaymentStates{

}

class PaymentRequestTokenKioskFailureState extends PaymentStates{
  String error;

  PaymentRequestTokenKioskFailureState(this.error);
}

class PaymentReferenceCodeSuccessState extends PaymentStates{

}

class PaymentReferenceCodeFailureState extends PaymentStates{
  String error;

  PaymentReferenceCodeFailureState(this.error);
}
