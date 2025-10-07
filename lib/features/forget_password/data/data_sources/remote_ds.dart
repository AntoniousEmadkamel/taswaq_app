import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../models/MessageModel.dart';

abstract class PasswordRemoteDS {
  Future<Either<Failures, MessageModel>> forgotPassword(String? email);
}