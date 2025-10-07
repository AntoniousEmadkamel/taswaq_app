import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/payment_entity.dart';
import '../repositories/payment_repo.dart';


class GetAuthTokenUsecase {
  final PaymentRepository repository;

  GetAuthTokenUsecase(this.repository);

  Future<Either<Failures, AuthTokenResponse>> call(String apiKey) {
    return repository.getAuthToken(apiKey);
  }
}