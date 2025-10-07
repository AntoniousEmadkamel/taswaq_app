import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/payment_entity.dart';
import '../repositories/payment_repo.dart';


class CreateOrderUsecase {
  final PaymentRepository repository;

  CreateOrderUsecase(this.repository);

  Future<Either<Failures, OrderResponse>> call({
    required String authToken,
    required String amount,
  }) {
    return repository.createOrder(
      authToken: authToken,
      amount: amount,
    );
  }
}