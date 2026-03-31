import 'package:arq_app/features/auth/data/models/user_model.dart';
import 'package:arq_app/features/auth/domain/entities/user_entities/user_entities.dart';
import 'package:arq_app/features/auth/domain/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepositoryImpl implements IAuthRepository {
  final FirebaseAuth _firebaseAuth;

  AuthRepositoryImpl(this._firebaseAuth);

  @override
  Future<UserEntities> login(String email, String password) async {
    try {
      final result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = result.user;

      if (user == null) {
        throw Exception('Usuario não encontrado');
      }

      return UserModel(
        name: user.displayName,
        email: email,
        nickName: '',
        picture: user.photoURL ?? '',
      );
    } on FirebaseAuthException catch (e) {
      throw Exception('${e.message} Erro ao realizar o login');
    } catch (e) {
      throw Exception('Erro de conexão');
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw ('Erro ao sair da conta');
    }
  }

  @override
  Future<UserEntities> register(String email, String password) async {
    try {
      final result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = result.user;

      if (user == null) throw Exception('Usuario invalido');
      return UserModel(
        name: user.displayName ?? 'Novo usuario',
        email: user.email ?? email,
        nickName: ' ',
        picture: user.photoURL ?? '',
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        throw Exception('Este e-mail já está sendo utilizado.');
      }
      throw Exception(e.message ?? 'Erro no cadastro');
    } catch (e) {
      throw Exception('Erro inesperado ao registrar');
    }
  }
}
