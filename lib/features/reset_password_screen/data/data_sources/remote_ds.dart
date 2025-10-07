import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../../forget_password/data/models/MessageModel.dart';

abstract class ResetPasswordDs {
  Future<Either<Failures, MessageModel>> resetPassword(
      String? email, String? password);
}