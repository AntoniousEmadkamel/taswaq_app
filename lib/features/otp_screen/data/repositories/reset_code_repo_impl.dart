import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../forget_password/data/models/MessageModel.dart';
import '../../domain/repositories/forgot_repo.dart';
import '../data_sources/remote_ds.dart';

class ResetCodeRepoImpl implements ResetCodeRepo {
  ResetCodeDS resetCodeDS;
  ResetCodeRepoImpl(this.resetCodeDS);

  @override
  Future<Either<Failures, MessageModel>> resetCode(String? code) =>
      resetCodeDS.resetCode(code);
}
