import '../../../../core/error/failures.dart';
import '../entities/UserEntity.dart';
import '../repositories/signup_repo.dart';
import 'package:dartz/dartz.dart';

class SignupUseCase {
 SignupRepo signupRepo;

 SignupUseCase(this.signupRepo);

 Future<Either<Failures,UserEntity>> call(String name , String email , String password ,String rePassword , String phone) =>signupRepo.signUp(name,email,password,rePassword,phone);
}