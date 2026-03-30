import 'package:arq_app/features/auth/domain/entities/UserEntities/user_entities.dart';

abstract class IAuthRepository {
  Future<UserEntities> login(String email, String password);
  Future<UserEntities> register(String email, String password);
  Future<void> logout();
}
