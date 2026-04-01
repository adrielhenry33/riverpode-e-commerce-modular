import 'package:arq_app/features/auth/domain/entities/user_entities/user_entities.dart';
import 'package:equatable/equatable.dart';

/// Base de todos os estados de Autenticação.
/// Estende [Equatable] para que o Riverpod identifique mudanças por VALOR e não por memória.
abstract class AuthStates extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Estado inicial: Aparece assim que a tela de Login é carregada.
class AuthInitial extends AuthStates {}

/// Estado de processamento: Ativado quando o UseCase está falando com o Firebase/API.
/// Ideal para mostrar Spinners ou Shimmer na UI.
class AuthLoading extends AuthStates {}

/// Estado de sucesso: Carrega a Entidade de usuário vinda do Domain.
/// A View usa o objeto [user] para mostrar dados após o login.
class AuthSuccess extends AuthStates {
  final UserEntities user;

  AuthSuccess(this.user);

  @override
  List<Object?> get props => [user]; // Equatable garante que o sucesso é único para este usuário.
}

/// Estado de erro: Captura a mensagem de falha lançada pelo Repositório/UseCase.
/// Permite que a UI exiba um SnackBar ou Alerta específico para o usuário.
class AuthError extends AuthStates {
  final String errorMessage;

  AuthError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

class AuthResetPasswordSucces extends AuthStates {
  final String emailSendTo;
  
  AuthResetPasswordSucces(this.emailSendTo);
  @override
  List<Object?> get props => [emailSendTo];
}
