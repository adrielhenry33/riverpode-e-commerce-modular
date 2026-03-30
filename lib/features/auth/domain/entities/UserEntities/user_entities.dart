class UserEntities {
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

  UserEntities copyWith({
    String? name,
    String? email,
    String? nickName,
    String? picture,
  }) {
    return UserEntities(
      name: name ?? this.name,
      email: email ?? this.email,
      nickName: nickName ?? this.nickName,
      picture: picture ?? this.picture,
    );
  }
}
