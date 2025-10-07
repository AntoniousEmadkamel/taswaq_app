import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:taswaq_app/core/api/api_manager.dart';
import 'package:taswaq_app/core/api/end_points.dart';
import 'package:taswaq_app/core/error/failures.dart';
import 'package:taswaq_app/features/login/data/data_sources/remote/remote_ds.dart';
import 'package:taswaq_app/features/signup/data/models/user_model.dart';

class LoginRemoteDsImpl implements LoginRemoteDs{
  ApiManager apiManager;
  LoginRemoteDsImpl(this.apiManager);

  Future <Either<Failures,UserModel>>signIn(String email, String password)async{
  try {
    Response response =await  apiManager.postData(
        endPoint: EndPoints.signIn, body: {
      "email": email,
      "password": password
    });
    UserModel userModel = UserModel.fromJson(response.data);
    return Right(userModel);
  }
  on DioException catch(e){
return Left(RemoteFailures(e.toString()));
  }
  catch(e){
    return Left(RemoteFailures(e.toString()));
  }

  }

}