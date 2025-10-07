import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../forget_password/data/models/MessageModel.dart';
import '../../domain/repositories/reset_password_repo.dart';
import '../data_sources/remote_ds.dart';


class ResetPasswordRepoImpl implements ResetPasswordRepo {
  ResetPasswordDs resetPasswordDs;

  ResetPasswordRepoImpl(this.resetPasswordDs);

  @override
  Future<Either<Failures, MessageModel>> resetPasswordRepo(
          String? email, String? password) =>
      resetPasswordDs.resetPassword(email, password);
}
