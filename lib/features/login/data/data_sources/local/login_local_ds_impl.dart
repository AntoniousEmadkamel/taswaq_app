import 'package:taswaq_app/features/login/data/data_sources/local/login_local_ds.dart';
import '../../../../../core/cashe/shared_preferences.dart';
class LoginLocalDsImpl implements LogInLocalDS{
  @override
  Future<bool> cacheToken(String token) async{
    try {
      return CacheData.saveData("token", token);
    } catch(e){
      throw Exception();
    }
  }

  @override
  Future<bool> cacheUserEmail(String email)async {
    try {
      return CacheData.saveData("email", email);
    } catch(e){
      throw Exception();
    }
  }

  @override
  Future<bool> cacheUserName(String name)async {
    try {
      return CacheData.saveData("name", name);
    } catch(e){
      throw Exception();
    }
  }

}