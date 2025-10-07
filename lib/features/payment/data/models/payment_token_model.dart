import '../../domain/entities/payment_entity.dart';

class PaymentTokenModel extends PaymentTokenResponse {
  const PaymentTokenModel({required super.token});

  factory PaymentTokenModel.fromJson(Map<String, dynamic> json) {
    return PaymentTokenModel(token: json['token']);
  }
}