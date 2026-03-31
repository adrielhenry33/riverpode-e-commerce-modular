import 'package:equatable/equatable.dart';

class UserEntities extends Equatable {
  final String? name;
  final String? email;
  final String? nickName;
  final String? picture;

  UserEntities({
    required this.name,
    required this.email,
    required this.nickName,
    required this.picture,
  });

  @override
  List<Object?> get props => [name, email, nickName];
}
