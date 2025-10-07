import 'package:dio/dio.dart';
import 'package:taswaq_app/core/api/api_manager.dart';
import 'package:taswaq_app/core/api/end_points.dart';
import 'package:taswaq_app/core/error/failures.dart';
import 'package:taswaq_app/features/signup/data/data_sources/remote/renote_ds.dart';
import 'package:taswaq_app/features/signup/data/models/user_model.dart';
import 'package:dartz/dartz.dart';

class SignUpRemoteDsImpl implements SignUpRemoteDs{
  ApiManager apiManager ;
  SignUpRemoteDsImpl(this.apiManager);
  @override
  Future<Either<Failures, UserModel>> signUp(String name, String email, String password, String rePassword, String phone) async{
  try{
    Response response =await apiManager.postData(endPoint: EndPoints.signUp, body:{
      "name": name,
      "email":email,
      "password":password,
      "rePassword":rePassword,
      "phone":phone
    });
    UserModel userModel=UserModel.fromJson(response.data);
    return Right(userModel);
  }
  catch(e){
  return Left(RemoteFailures(e.toString()));
  }
  }
}