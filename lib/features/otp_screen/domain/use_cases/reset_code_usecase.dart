import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../forget_password/data/models/MessageModel.dart';
import '../repositories/forgot_repo.dart';

class ResetCodeUseCase {
  ResetCodeRepo resetCodeRepo;
  ResetCodeUseCase(this.resetCodeRepo);

  Future<Either<Failures, MessageModel>> call(String? code) =>
      resetCodeRepo.resetCode(code);
}