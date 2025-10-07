import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/payment_entity.dart';
import '../repositories/payment_repo.dart';


class GetReferenceCodeUsecase {
  final PaymentRepository repository;

  GetReferenceCodeUsecase(this.repository);

  Future<Either<Failures, ReferenceCodeResponse>> call(String kioskToken) {
    return repository.getReferenceCode(kioskToken);
  }
}