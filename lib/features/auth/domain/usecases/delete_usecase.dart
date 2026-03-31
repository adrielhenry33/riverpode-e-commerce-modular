import '../repository/auth_repository.dart';

class DeleteAccountUsecase {
  final IAuthRepository _repository;

  DeleteAccountUsecase(this._repository);

  Future<void> call() async {
    return await _repository.delete();
  }
}
