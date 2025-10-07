import '../../domain/entities/payment_entity.dart';

class AuthTokenModel extends AuthTokenResponse {
  const AuthTokenModel({required super.token});

  factory AuthTokenModel.fromJson(Map<String, dynamic> json) {
    return AuthTokenModel(token: json['token']);
  }
}