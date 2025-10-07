class PaymentRequest {
  final String email;
  final String phone;
  final String firstName;
  final String lastName;
  final String amount;

  const PaymentRequest({
    required this.email,
    required this.phone,
    required this.firstName,
    required this.lastName,
    required this.amount,
  });
}

class AuthTokenResponse {
  final String token;

  const AuthTokenResponse({required this.token});
}

class OrderResponse {
  final String orderId;

  const OrderResponse({required this.orderId});
}

class PaymentTokenResponse {
  final String token;

  const PaymentTokenResponse({required this.token});
}

class ReferenceCodeResponse {
  final String referenceCode;

  const ReferenceCodeResponse({required this.referenceCode});
}