import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:estrello_gabriela_examen_segundo_parcial/modules/products/domain/dto/product.dart';
import 'package:estrello_gabriela_examen_segundo_parcial/screens/productoDetallado.dart';

class Carrito extends StatefulWidget {
  @override
  _CarritoState createState() => _CarritoState();
}

class _CarritoState extends State<Carrito> {
  List<Map<String, dynamic>> cartItems = [];
  double totalTodo = 0.0;

  @override
  void initState() {
    super.initState();
    _loadCart();
  }

  Future<void> _loadCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> carritoGuardado = prefs.getStringList('cart') ?? [];

    double total = 0.0;
    List<Map<String, dynamic>> items = [];

    for (var item in carritoGuardado) {
      Map<String, dynamic> decodedItem = jsonDecode(item);

      if (decodedItem['images'] is! List<String>) {
        decodedItem['images'] = List<String>.from(decodedItem['images'] ?? []);
      }

      total += decodedItem['total'];
      items.add(decodedItem);
    }

    setState(() {
      cartItems = items;
      totalTodo = total; 
    });
  }

  Future<void> _removeFromCart(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      cartItems.removeAt(index);
    });
    List<String> updatedCart = cartItems.map((item) => jsonEncode(item)).toList();
    await prefs.setStringList('cart', updatedCart);
    _calculateTotal();
  }

  void _calculateTotal() {
    double total = 0.0;
    for (var item in cartItems) {
      total += item['total'];
    }
    setState(() {
      totalTodo = total; 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carrito - Total: \$${totalTodo.toStringAsFixed(2)}"),
        backgroundColor: Colors.blue,
      ),
      body: cartItems.isEmpty
          ? Center(child: Text("El carrito no tiene nada pipipipi, agregue algún producto"))
          : ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];

                String imageUrl = (item['images'] != null && (item['images'] as List).isNotEmpty)
                    ? item['images'][0]
                    : 'https://via.placeholder.com/150';

                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    leading: Image.network(
                      imageUrl,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                    title: Text(item['nombre'] ?? 'Este producto no tiene nombre'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Cantidad: ${item['cantidad']}"),
                        Text("Total: \$${(item['total'] ?? 0).toStringAsFixed(2)}"),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.visibility),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductoDetallado(
                                  product: Product(
                                    id: item['id'] ?? 0,
                                    titulo: item['nombre'] ?? 'Este producto no tiene nombre',
                                    descripcion: item['descripcion'] ?? 'La descripción no se encuentra disponible por el momento',
                                    precio: item['precio'] ?? 0.0,
                                    stock: item['stock'] ?? 0,
                                    images: List<String>.from(item['images'] ?? ['https://via.placeholder.com/150']),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            _removeFromCart(index);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
