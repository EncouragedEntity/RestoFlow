import 'package:resto_flow/models/auth/auth_token_dto.dart';
import 'package:resto_flow/models/auth/user.dart';

class AuthResponseDto {
  final AuthTokenDTO authTokenDTO;
  final User userDTO;

  AuthResponseDto({
    required this.authTokenDTO,
    required this.userDTO,
  });

  factory AuthResponseDto.fromJson(Map<String, dynamic> json) {
    return AuthResponseDto(
      authTokenDTO: AuthTokenDTO.fromJson(json['authTokenDTO']),
      userDTO: User.fromJson(json['userDTO']),
    );
  }
}
