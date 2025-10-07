import 'package:dartz/dartz.dart';
import 'package:taswaq_app/core/error/failures.dart';
import 'package:taswaq_app/features/signup/data/models/user_model.dart';

 abstract class LoginRepo{
  Future <Either<Failures,UserModel>> signIn(String email, String password);
}