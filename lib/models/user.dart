class User {
  final int id;
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final List<String> authorities;
  final int bonusScore;
  final bool deleted;
  final String password;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.authorities,
    required this.bonusScore,
    required this.deleted,
    required this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      username: json['username'] as String,
      email: json['email'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      authorities: List<String>.from(json['authorities']),
      bonusScore: json['bonusScore'] as int,
      deleted: json['deleted'] as bool,
      password: json['password'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'authorities': authorities,
      'bonusScore': bonusScore,
      'deleted': deleted,
      'password': password,
    };
  }
}
