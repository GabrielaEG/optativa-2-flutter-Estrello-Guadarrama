import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:estrello_gabriela_examen_segundo_parcial/router/routers.dart';
import 'package:estrello_gabriela_examen_segundo_parcial/modules/login/domain/dto/user_credentials.dart';
import 'package:estrello_gabriela_examen_segundo_parcial/modules/login/useCase/login_usecase.dart';

class Login extends StatefulWidget {
  final LoginUseCase loginUseCase;

  Login({required this.loginUseCase});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _checkToken(); 
  }

  Future<void> _checkToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('authToken')) {
      Navigator.pushReplacementNamed(context, Routers.productosCategoria);
    }
  }

  void _login() async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    final credentials = UserCredentials(user: username, password: password);

    try {
      final response = await widget.loginUseCase.execute(credentials);
      print("Token almacenado: ${response.accessToken}");

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('authToken', response.accessToken);

      Navigator.pushReplacementNamed(context, Routers.productosCategoria);
    } catch (e) {
      print("Error en login: $e");
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Error"),
          content: Text("No se pudo iniciar sesión. Por favor, revisa la contraseña o el usuario."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20), 
                child: Container(
                  width: 250,  
                  height: 180, 
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueAccent, width: 2), 
                  ),
                  child: Image.asset(
                    'assets/images/login_image.png', 
                    fit: BoxFit.cover, 
                  ),
                ),
              ),
              SizedBox(height: 20), 
              
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Usuario',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 10),
              
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                obscureText: true,
              ),
              SizedBox(height: 20),
              
              ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text("Ingresar", style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
