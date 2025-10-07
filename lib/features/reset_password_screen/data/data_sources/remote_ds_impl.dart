import 'dart:convert';
import 'dart:math';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:taswaq_app/features/reset_password_screen/data/data_sources/remote_ds.dart';
import '../../../../../core/api/api_manager.dart';
import '../../../../../core/api/end_points.dart';
import '../../../../../core/error/failures.dart';
import '../../../cart_screen/data/models/ErrorModel.dart';
import '../../../forget_password/data/models/MessageModel.dart';

class ResetPasswordDsImpl implements ResetPasswordDs {
  ApiManager apiManager;
  ResetPasswordDsImpl(this.apiManager);

  @override
  Future<Either<Failures, MessageModel>> resetPassword(
      String? email, String? password) async {
    try {
      Response response = await apiManager.putData(
          endPoint: EndPoints.resetPassword,
          body: {"email": email, "newPassword": password});

      MessageModel messageModel = MessageModel.fromJson(response.data);
      return Right(messageModel);
    } on DioException catch (e) {
      Map<String, dynamic> response = jsonDecode(e.response.toString());
      ErrorModel errorModel = ErrorModel.fromJson(response);
      return Left(RemoteFailures(errorModel.message ?? ""));
    }
  }
}
