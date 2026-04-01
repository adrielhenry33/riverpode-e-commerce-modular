
import 'package:arq_app/features/auth/domain/entities/user_entities/user_entities.dart';

class UserModel extends UserEntities {
  const UserModel({
    required super.name,
    required super.email,
    required super.nickName,
    required super.picture,
  });

  factory UserModel.fromMap(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] ?? 'Nome usuario',
      email: json['email'] ?? 'email usuario',
      nickName: json['nickName'] ?? 'Sobrenome',
      picture: json['picture'] ?? 'Imagem de perfil',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'nickName': nickName,
      'picture': picture,
    };
  }

  UserModel copyWith({
    String? name,
    String? email,
    String? nickName,
    String? picture,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      nickName: nickName ?? this.nickName,
      picture: picture ?? this.picture,
    );
  }
}
