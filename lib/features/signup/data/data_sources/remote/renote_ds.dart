import 'package:taswaq_app/core/error/failures.dart';
import 'package:taswaq_app/features/signup/data/models/user_model.dart';
import 'package:dartz/dartz.dart';

abstract class  SignUpRemoteDs{
  Future<Either<Failures,UserModel>> signUp(String name , String email , String password ,String rePassword , String phone);
}