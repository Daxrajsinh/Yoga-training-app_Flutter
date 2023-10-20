class UserModel {
  static String UserTable = "Users";
  static String IDName = "ID";
  static String Username = "Username";
  static String Password = "Password";
}

class User {
  int? id;
  String username;
  String password;

  User({
    this.id,
    required this.username,
    required this.password,
  });

  User copy({
    int? id,
    String? username,
    String? password,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  static User fromJson(Map<String, Object?> json) {
    return User(
      id: json[UserModel.IDName] as int?,
      username: json[UserModel.Username] as String,
      password: json[UserModel.Password] as String,
    );
  }

  Map<String, Object?> toJson() {
    return {
      UserModel.IDName: id,
      UserModel.Username: username,
      UserModel.Password: password,
    };
  }
}