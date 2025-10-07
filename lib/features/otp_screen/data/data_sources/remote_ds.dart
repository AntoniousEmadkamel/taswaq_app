import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../../forget_password/data/models/MessageModel.dart';

abstract class ResetCodeDS {
  Future<Either<Failures, MessageModel>> resetCode(String? code);
}