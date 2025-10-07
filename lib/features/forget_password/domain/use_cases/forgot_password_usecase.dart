import 'package:dartz/dartz.dart';


import '../../../../core/error/failures.dart';
import '../../data/models/MessageModel.dart';
import '../repositories/forgot_repo.dart';

class ForgotPasswordUseCase {
  ForgotPasswordRepo forgotPasswordRepo;

  ForgotPasswordUseCase(this.forgotPasswordRepo);

  Future<Either<Failures, MessageModel>> call(String? email) =>
      forgotPasswordRepo.forgotPassword(email);
}

