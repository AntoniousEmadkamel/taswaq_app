abstract class LogInLocalDS {
  Future<bool> cacheToken(String token);
  Future<bool> cacheUserName(String name);
  Future<bool> cacheUserEmail(String email);
}