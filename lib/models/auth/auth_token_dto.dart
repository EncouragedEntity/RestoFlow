class AuthTokenDTO {
  final String accessToken;
  final String refreshToken;

  AuthTokenDTO({
    required this.accessToken,
    required this.refreshToken,
  });

  factory AuthTokenDTO.fromJson(Map<String, dynamic> json) {
    return AuthTokenDTO(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
    );
  }
}
