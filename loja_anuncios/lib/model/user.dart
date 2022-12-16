final String tableUsers = 'users';

class UsersFields {
  static final List<String> values = [id,name,email,password];
  static final String id = '_id';
  static final String name = 'name';
  static final String email = 'email';
  static final String password = 'password';

}

class User {
  final int? id;
  final String name;
  final String email;
  final String password;

  const User({
    this.id,
    required this.name,
    required this.email,
    required this.password
  });
  User copy({
    int? id,
    String? name,
    String? email,
    String? password,
  }) =>
      User(
          id: id ?? this.id,
          name: name ?? this.name,
          email: email ?? this.email,
          password: password ?? this.password);

  static User fromJson(Map<String, Object?> json) => User(
    id: json[UsersFields.id] as int?,
    name: json[UsersFields.name] as String,
    email: json[UsersFields.email] as String,
    password: json[UsersFields.password] as String,
  );


  Map<String, Object?> toJson() => {
    UsersFields.id: id,
    UsersFields.name: name,
    UsersFields.email: email,
    UsersFields.password: password,
  };
}
