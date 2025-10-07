import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/MessageModel.dart';

abstract class ForgotPasswordRepo {
  Future<Either<Failures, MessageModel>> forgotPassword(String? email);
}