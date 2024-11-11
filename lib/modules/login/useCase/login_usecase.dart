import 'package:estrello_gabriela_examen_segundo_parcial/modules/login/domain/dto/user_credentials.dart';
import 'package:estrello_gabriela_examen_segundo_parcial/modules/login/domain/dto/user_response.dart';
import 'package:estrello_gabriela_examen_segundo_parcial/modules/login/domain/repository/login_respository.dart';

class LoginUseCase {
  final LoginRepository repository;

  LoginUseCase(this.repository);

  Future<UserLoginResponse> execute(UserCredentials params) async {
    return await repository.execute(params);
  }

  Future<bool> isAuthenticated() async {
    return await repository.hasToken();
  }

  Future<String?> getToken() async {
    return await repository.getToken();
  }
}
