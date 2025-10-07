import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/payment_entity.dart';
import '../repositories/payment_repo.dart';

class GetKioskPaymentTokenUsecase {
  final PaymentRepository repository;

  GetKioskPaymentTokenUsecase(this.repository);

  Future<Either<Failures, PaymentTokenResponse>> call({
    required String authToken,
    required String orderId,
    required String amount,
    required PaymentRequest paymentRequest,
    required int integrationId,
  }) {
    return repository.getKioskPaymentToken(
      authToken: authToken,
      orderId: orderId,
      amount: amount,
      paymentRequest: paymentRequest,
      integrationId: integrationId,
    );
  }
}