import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../forget_password/data/models/MessageModel.dart';

abstract class ResetPasswordRepo {
  Future<Either<Failures, MessageModel>> resetPasswordRepo(
      String? email, String? password);
}
