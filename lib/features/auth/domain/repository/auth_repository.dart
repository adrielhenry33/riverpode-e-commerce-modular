abstract class IAuthRepository {
  Future<int> login(String email, String password);
  Future<int> register(String email, String password);
  Future<void> logout();
}
