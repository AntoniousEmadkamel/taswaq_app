import 'package:taswaq_app/features/payment/data/data_sources/payment_remote_ds.dart';

import '../../../../core/network/dio_helper_for_paymob.dart';
import '../../domain/entities/payment_entity.dart';
import '../models/auth_token_model.dart';
import '../models/order_model.dart';
import '../models/payment_token_model.dart';
import '../models/refrence_code_model.dart';

class PaymentRemoteDataSourceImpl implements PaymentRemoteDataSource {
  @override
  Future<AuthTokenModel> getAuthToken(String apiKey) async {
    final response = await DioHelper.postData(
      endPoint: "auth/tokens",
      data: {"api_key": apiKey},
    );
    return AuthTokenModel.fromJson(response.data);
  }

  @override
  Future<OrderModel> createOrder({
    required String authToken,
    required String amount,
  }) async {
    final response = await DioHelper.postData(
      endPoint: "ecommerce/orders",
      data: {
        "auth_token": authToken,
        "delivery_needed": "false",
        "amount_cents": amount,
        "currency": "EGP",
        "items": []
      },
    );
    return OrderModel.fromJson(response.data);
  }

  @override
  Future<PaymentTokenModel> getCardPaymentToken({
    required String authToken,
    required String orderId,
    required String amount,
    required PaymentRequest paymentRequest,
    required int integrationId,
  }) async {
    final response = await DioHelper.postData(
      endPoint: "acceptance/payment_keys",
      data: {
        "auth_token": authToken,
        "amount_cents": amount,
        "expiration": 3600,
        "order_id": orderId,
        "billing_data": {
          "apartment": "NA",
          "email": paymentRequest.email,
          "floor": "NA",
          "first_name": paymentRequest.firstName,
          "street": "NA",
          "building": "NA",
          "phone_number": paymentRequest.phone,
          "shipping_method": "NA",
          "postal_code": "NA",
          "city": "NA",
          "country": "EG",
          "last_name": paymentRequest.lastName,
          "state": "NA"
        },
        "currency": "EGP",
        "integration_id": integrationId
      },
    );
    return PaymentTokenModel.fromJson(response.data);
  }

  @override
  Future<PaymentTokenModel> getKioskPaymentToken({
    required String authToken,
    required String orderId,
    required String amount,
    required PaymentRequest paymentRequest,
    required int integrationId,
  }) async {
    final response = await DioHelper.postData(
      endPoint: "acceptance/payment_keys",
      data: {
        "auth_token": authToken,
        "amount_cents": amount,
        "expiration": 3600,
        "order_id": orderId,
        "billing_data": {
          "apartment": "NA",
          "email": paymentRequest.email,
          "floor": "NA",
          "first_name": paymentRequest.firstName,
          "street": "NA",
          "building": "NA",
          "phone_number": paymentRequest.phone,
          "shipping_method": "NA",
          "postal_code": "NA",
          "city": "NA",
          "country": "EG",
          "last_name": paymentRequest.lastName,
          "state": "NA"
        },
        "currency": "EGP",
        "integration_id": integrationId
      },
    );
    return PaymentTokenModel.fromJson(response.data);
  }

  @override
  Future<ReferenceCodeModel> getReferenceCode(String kioskToken) async {
    final response = await DioHelper.postData(
      endPoint: "acceptance/payments/pay",
      data: {
        "source": {"identifier": "AGGREGATOR", "subtype": "AGGREGATOR"},
        "payment_token": kioskToken
      },
    );
    return ReferenceCodeModel.fromJson(response.data);
  }
}