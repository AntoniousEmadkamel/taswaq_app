import '../../domain/entities/payment_entity.dart';

class OrderModel extends OrderResponse {
  const OrderModel({required super.orderId});

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(orderId: json['id'].toString());
  }
}