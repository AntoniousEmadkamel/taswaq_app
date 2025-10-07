import '../../domain/entities/payment_entity.dart';
import '../models/auth_token_model.dart';
import '../models/order_model.dart';
import '../models/payment_token_model.dart';
import '../models/refrence_code_model.dart';

abstract class PaymentRemoteDataSource {
  Future<AuthTokenModel> getAuthToken(String apiKey);
  Future<OrderModel> createOrder({required String authToken, required String amount});
  Future<PaymentTokenModel> getCardPaymentToken({
    required String authToken,
    required String orderId,
    required String amount,
    required PaymentRequest paymentRequest,
    required int integrationId,
  });
  Future<PaymentTokenModel> getKioskPaymentToken({
    required String authToken,
    required String orderId,
    required String amount,
    required PaymentRequest paymentRequest,
    required int integrationId,
  });
  Future<ReferenceCodeModel> getReferenceCode(String kioskToken);
}