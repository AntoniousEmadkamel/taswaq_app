import 'package:taswaq_app/core/error/failures.dart';
import 'package:taswaq_app/features/signup/data/data_sources/remote/renote_ds.dart';
import 'package:taswaq_app/features/signup/data/models/user_model.dart';
import '../../domain/repositories/signup_repo.dart';
import 'package:dartz/dartz.dart';

class SignupRepoImpl implements SignupRepo{
SignUpRemoteDs signUpRemoteDs;
SignupRepoImpl(this.signUpRemoteDs);
Future<Either<Failures,UserModel>> signUp(String name , String email , String password ,String rePassword , String phone) =>signUpRemoteDs.signUp(name, email, password, rePassword, phone) ;
}