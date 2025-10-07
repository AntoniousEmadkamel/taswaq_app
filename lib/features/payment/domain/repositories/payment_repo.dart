// lib/features/payment/domain/repositories/payment_repository.dart
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/payment_entity.dart';
abstract class PaymentRepository {
  Future<Either<Failures, AuthTokenResponse>> getAuthToken(String apiKey);

  Future<Either<Failures, OrderResponse>> createOrder({
    required String authToken,
    required String amount,
  });

  Future<Either<Failures, PaymentTokenResponse>> getCardPaymentToken({
    required String authToken,
    required String orderId,
    required String amount,
    required PaymentRequest paymentRequest,
    required int integrationId,
  });

  Future<Either<Failures, PaymentTokenResponse>> getKioskPaymentToken({
    required String authToken,
    required String orderId,
    required String amount,
    required PaymentRequest paymentRequest,
    required int integrationId,
  });

  Future<Either<Failures, ReferenceCodeResponse>> getReferenceCode(String kioskToken);
}