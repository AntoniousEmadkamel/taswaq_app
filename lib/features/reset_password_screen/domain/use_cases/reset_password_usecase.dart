import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../forget_password/data/models/MessageModel.dart';
import '../repositories/reset_password_repo.dart';

class ResetPasswordUseCase {
  ResetPasswordRepo resetPasswordRepo;
  ResetPasswordUseCase(this.resetPasswordRepo);

  Future<Either<Failures, MessageModel>> call(
          String? email, String? password) =>
      resetPasswordRepo.resetPasswordRepo(email, password);
}
