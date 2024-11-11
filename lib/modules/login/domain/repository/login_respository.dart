import 'package:shared_preferences/shared_preferences.dart';
import 'package:estrello_gabriela_examen_segundo_parcial/infrastructure/connection/connection.dart';
import 'package:estrello_gabriela_examen_segundo_parcial/modules/login/domain/dto/user_credentials.dart';
import 'package:estrello_gabriela_examen_segundo_parcial/modules/login/domain/dto/user_response.dart';

class LoginRepository {
  final Connection connection;
  final String loginUrl = 'https://dummyjson.com/auth/login';

  LoginRepository(this.connection);

  Future<UserLoginResponse> execute(UserCredentials params) async {
    final data = {
      "username": params.user,
      "password": params.password,
    };

    final response = await connection.post<Map<String, dynamic>, Map<String, dynamic>>(
      loginUrl,
      data,
      headers: {'Content-Type': 'application/json'},
    );

    final loginResponse = UserLoginResponse.fromJson(response);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken', loginResponse.accessToken);

    return loginResponse;
  }

  Future<bool> hasToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('accessToken');
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken');
  }
}
