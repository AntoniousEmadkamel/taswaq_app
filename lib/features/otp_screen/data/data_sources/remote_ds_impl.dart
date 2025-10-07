import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:taswaq_app/features/otp_screen/data/data_sources/remote_ds.dart';
import '../../../../../core/api/api_manager.dart';
import '../../../../../core/api/end_points.dart';
import '../../../../../core/error/failures.dart';
import '../../../cart_screen/data/models/ErrorModel.dart';
import '../../../forget_password/data/models/MessageModel.dart';

class ResetCodeDsImpl implements ResetCodeDS {
  ApiManager apiManager;
  ResetCodeDsImpl(this.apiManager);

  @override
  Future<Either<Failures, MessageModel>> resetCode(String? code) async {
    try {
      Response response = await apiManager
          .postData(endPoint: EndPoints.resetCode, body: {"resetCode": code});
      MessageModel messageModel = MessageModel.fromJson(response.data);
      return Right(messageModel);
    } on DioException catch (e) {
      Map<String, dynamic> response = jsonDecode(e.response.toString());
      ErrorModel errorModel = ErrorModel.fromJson(response);
      return Left(RemoteFailures(errorModel.message ?? ""));
    }
  }
}