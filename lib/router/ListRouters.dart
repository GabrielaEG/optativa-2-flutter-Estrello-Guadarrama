import 'package:flutter/material.dart';
import 'package:estrello_gabriela_examen_segundo_parcial/router/routers.dart';
import 'package:estrello_gabriela_examen_segundo_parcial/screens/login.dart';
import 'package:estrello_gabriela_examen_segundo_parcial/screens/categorias.dart';
import 'package:estrello_gabriela_examen_segundo_parcial/screens/productoDetallado.dart';
import 'package:estrello_gabriela_examen_segundo_parcial/modules/login/domain/repository/login_respository.dart';
import 'package:estrello_gabriela_examen_segundo_parcial/modules/login/useCase/login_usecase.dart';
import 'package:estrello_gabriela_examen_segundo_parcial/modules/products/domain/dto/product.dart';
import 'package:estrello_gabriela_examen_segundo_parcial/router/menu_option/menu_options.dart';
import 'package:estrello_gabriela_examen_segundo_parcial/infrastructure/connection/connection.dart';
import 'package:estrello_gabriela_examen_segundo_parcial/screens/carrito.dart';

final loginRepository = LoginRepository(Connection());
final loginUseCase = LoginUseCase(loginRepository);

class ListRouters {
  static final Map<String, Widget Function(BuildContext)> listScreens = {
    Routers.login: (context) => Login(loginUseCase: loginUseCase),
    Routers.productosCategoria: (context) => CategoryScreen(),
    Routers.productoDetallado: (context) => ProductoDetallado(
      product: Product(
        id: 1,
        titulo: 'Ejemplo de producto',
        descripcion: 'Descripción de ejemplo del producto',
        precio: 12.95,
        stock: 68,
        images: ['https://via.placeholder.com/150'], 
      ),
    ),
    Routers.carrito: (context) => Carrito(),
  };

  static List<MenuOption> menuOptions = [
    MenuOption(
      route: Routers.login,
      screen: Login(loginUseCase: loginUseCase),
      icon: Icons.login,
      description: "Pantalla de Login",
    ),
    MenuOption(
      route: Routers.productosCategoria,
      screen: CategoryScreen(),
      icon: Icons.category,
      description: "Pantalla de Productos por Categoría",
    ),
    MenuOption(
      route: Routers.productoDetallado,
      screen: ProductoDetallado(
        product: Product(
          id: 1,
          titulo: 'Ejemplo de producto',
          descripcion: 'Descripción de ejemplo del producto',
          precio: 9.99,
          stock: 10,
          images: ['https://via.placeholder.com/150'], 
        ),
      ),
      icon: Icons.info,
      description: "Pantalla de Producto Detallado",
    ),
  ];
}
