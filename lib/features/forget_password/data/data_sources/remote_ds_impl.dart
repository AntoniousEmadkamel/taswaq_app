import 'dart:convert';
import 'dart:math';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:taswaq_app/features/forget_password/data/data_sources/remote_ds.dart';
import '../../../../../core/api/api_manager.dart';
import '../../../../../core/api/end_points.dart';
import '../../../../../core/error/failures.dart';
import '../../../cart_screen/data/models/ErrorModel.dart';
import '../models/MessageModel.dart';

class PasswordRemoteDSImpl implements PasswordRemoteDS {
  ApiManager apiManager;
  PasswordRemoteDSImpl(this.apiManager);

  @override
  Future<Either<Failures, MessageModel>> forgotPassword(String? email) async {
    try {
      Response response = await apiManager
          .postData(endPoint: EndPoints.forgotPassword, body: {"email": email});
      MessageModel messageModel = MessageModel.fromJson(response.data);
      return Right(messageModel);
    } on DioException catch (e) {
      Map<String, dynamic> response = jsonDecode(e.response.toString());
      ErrorModel errorModel = ErrorModel.fromJson(response);

      return Left(RemoteFailures(errorModel.message ?? ""));
    }
  }
}

