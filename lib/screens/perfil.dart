import 'package:estrello_gabriela_examen_segundo_parcial/router/routers.dart';
import 'package:flutter/material.dart';
import 'package:estrello_gabriela_examen_segundo_parcial/components/NavigatorBar.dart';

class PerfilPantalla extends StatelessWidget {
  void _onNavBarTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushNamed(context, Routers.busqueda);
        break;
      case 1:
        Navigator.pushNamed(context, Routers.carrito);
        break;
      case 2:
        Navigator.pushNamed(context, Routers.visitado);
        break;
      case 3:
        break; 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Perfil"),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Text("Info del usuario."),
      ),
      bottomNavigationBar: CustomNavigationBar(
        currentIndex: 3, 
        onTap: (index) => _onNavBarTap(context, index),
      ),
    );
  }
}
