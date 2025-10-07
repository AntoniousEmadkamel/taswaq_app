import 'package:taswaq_app/core/error/failures.dart';
import 'package:taswaq_app/features/signup/data/models/user_model.dart';
import 'package:taswaq_app/features/signup/domain/entities/UserEntity.dart';
import 'package:dartz/dartz.dart';
import '../repositories/login_repo.dart';

class LoginUseCase{
 LoginRepo loginRepo;
 LoginUseCase( this.loginRepo);

 Future <Either<Failures,UserModel>> call(String email, String password)=>loginRepo.signIn(email, password);
}