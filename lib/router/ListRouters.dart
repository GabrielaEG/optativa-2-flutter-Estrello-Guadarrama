import 'package:flutter/material.dart';
import 'package:estrello_gabriela_examen_segundo_parcial/router/routers.dart';
import 'package:estrello_gabriela_examen_segundo_parcial/screens/login.dart';
import 'package:estrello_gabriela_examen_segundo_parcial/screens/categorias.dart';
import 'package:estrello_gabriela_examen_segundo_parcial/screens/productoDetallado.dart';
import 'package:estrello_gabriela_examen_segundo_parcial/screens/productosCategoría.dart';
import 'package:estrello_gabriela_examen_segundo_parcial/modules/products/domain/dto/product.dart';
import 'package:estrello_gabriela_examen_segundo_parcial/router/menu_option/menu_options.dart';

class ListRouters {
  static final Map<String, Widget Function(BuildContext)> listScreens = {
    Routers.login: (context) => Login(),
    Routers.productosCategoria: (context) => CategoryScreen(),
    Routers.productoDetallado: (context) => ProductoDetallado(
      product: Product(
        id: 1,
        titulo: 'Producto de Ejemplo',
        descripcion: 'Descripción de ejemplo del producto',
        precio: 9.99,
        stock: 10, 
        imageUrl: 'https://via.placeholder.com/150', 
      ),
    ),
  };

  static List<MenuOption> menuOptions = [
    MenuOption(
      route: Routers.login,
      screen: Login(),
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
          titulo: 'Producto de Ejemplo',
          descripcion: 'Descripción de ejemplo del producto',
          precio: 9.99,
          stock: 10, 
          imageUrl: 'https://via.placeholder.com/150', 
        ),
      ),
      icon: Icons.info,
      description: "Pantalla de Producto Detallado",
    ),
  ];
}
