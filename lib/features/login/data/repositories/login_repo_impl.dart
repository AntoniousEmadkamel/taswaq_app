import 'package:dartz/dartz.dart';
import 'package:taswaq_app/core/error/failures.dart';
import 'package:taswaq_app/features/login/data/data_sources/remote/remote_ds.dart';
import 'package:taswaq_app/features/login/domain/repositories/login_repo.dart';
import '../../../signup/data/models/user_model.dart';
import '../data_sources/local/login_local_ds.dart';

class LoginRepoImpl implements LoginRepo{
LoginRemoteDs loginRemoteDs;
LogInLocalDS localDS;

LoginRepoImpl(this.loginRemoteDs,this.localDS);

  @override
  Future<Either<Failures, UserModel>> signIn(String email, String password) async{
    try {
     var result= await loginRemoteDs.signIn(email, password);
     if (result.isRight()) {
       result.fold((l) => null, (r) {
         cacheToken(r.token ?? "");
         cacheUserName(r.user?.name ?? "");
         cacheUserEmail(r.user?.email ?? "");
       });
     }
     return result;
    }catch(e){
      throw Exception(RemoteFailures("something went wrong"));
    }
  }

  void cacheToken(String token) {
    localDS.cacheToken(token);
  }

  void cacheUserName(String name) {
    localDS.cacheUserName(name);
  }

  void cacheUserEmail(String email) {
    localDS.cacheUserEmail(email);
  }

}