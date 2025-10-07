import 'package:taswaq_app/core/error/failures.dart';
import 'package:taswaq_app/features/signup/domain/entities/UserEntity.dart';
import 'package:dartz/dartz.dart';

abstract class SignupRepo{
  Future<Either<Failures,UserEntity>> signUp(String name , String email , String password ,String rePassword , String phone);
}