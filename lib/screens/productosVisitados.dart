import 'package:estrello_gabriela_examen_segundo_parcial/router/routers.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:estrello_gabriela_examen_segundo_parcial/modules/products/domain/dto/product.dart';
import 'package:estrello_gabriela_examen_segundo_parcial/screens/productoDetallado.dart';
import 'package:estrello_gabriela_examen_segundo_parcial/components/NavigatorBar.dart';

class ProductosVisitados extends StatefulWidget {
  @override
  _ProductosVisitadosState createState() => _ProductosVisitadosState();
}

class _ProductosVisitadosState extends State<ProductosVisitados> {
  List<Map<String, dynamic>> visitedProducts = [];

  @override
  void initState() {
    super.initState();
    _loadVisitedProducts();
  }

  Future<void> _loadVisitedProducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> savedProducts = prefs.getStringList('visitedProducts') ?? [];
    List<Map<String, dynamic>> items = savedProducts
        .map((item) => jsonDecode(item) as Map<String, dynamic>) 
        .toList();
    setState(() {
      visitedProducts = items;
    });
  }

  void _onNavBarTap(int index) {
    switch (index) {
      case 0:
        Navigator.pushNamed(context, Routers.busqueda);
        break;
      case 1:
        Navigator.pushNamed(context, Routers.carrito);
        break;
      case 2:
        break; 
      case 3:
        Navigator.pushNamed(context, Routers.pefil);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Productos Vistos"),
        backgroundColor: Colors.blue,
      ),
      body: visitedProducts.isEmpty
          ? Center(child: Text("No has visto ningún producto aún."))
          : ListView.builder(
              itemCount: visitedProducts.length,
              itemBuilder: (context, index) {
                final product = visitedProducts[index];
                return ListTile(
                  title: Text(product['nombre']),
                  subtitle: Text("Veces visto: ${product['views']}"),
                  trailing: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductoDetallado(
                            product: Product(
                              id: product['id'],
                              titulo: product['nombre'],
                              descripcion: product['descripcion'],
                              precio: product['precio'],
                              stock: product['stock'],
                              images: List<String>.from(product['images']),
                            ),
                          ),
                        ),
                      );
                    },
                    child: Text("Ver Producto"),
                  ),
                );
              },
            ),
      bottomNavigationBar: CustomNavigationBar(
        currentIndex: 2,
        onTap: _onNavBarTap,
      ),
    );
  }
}
