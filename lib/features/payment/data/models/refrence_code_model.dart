import '../../domain/entities/payment_entity.dart';

class ReferenceCodeModel extends ReferenceCodeResponse {
  const ReferenceCodeModel({required super.referenceCode});

  factory ReferenceCodeModel.fromJson(Map<String, dynamic> json) {
    return ReferenceCodeModel(referenceCode: json['id'].toString());
  }
}