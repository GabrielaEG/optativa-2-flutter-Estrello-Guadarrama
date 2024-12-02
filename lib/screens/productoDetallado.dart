import 'package:flutter/material.dart';
import 'package:estrello_gabriela_examen_segundo_parcial/modules/products/domain/dto/product.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:estrello_gabriela_examen_segundo_parcial/screens/carrito.dart';
import 'package:estrello_gabriela_examen_segundo_parcial/modules/products/useCase/products_visited.dart';
import 'package:estrello_gabriela_examen_segundo_parcial/modules/products/useCase/prodcut_review.dart';

class ProductoDetallado extends StatefulWidget {
  final Product product;

  ProductoDetallado({required this.product});

  @override
  _ProductoDetalladoState createState() => _ProductoDetalladoState();
}

class _ProductoDetalladoState extends State<ProductoDetallado> {
  final TextEditingController _cantidadController = TextEditingController();
  final VisitedProductsUseCase visitedProductsUseCase = VisitedProductsUseCase();
  final ProductReviewsUseCase productReviewsUseCase = ProductReviewsUseCase();

  List<Map<String, dynamic>> reviews = [];
  bool isLoadingReviews = true;

  @override
  void initState() {
    super.initState();
    _markProductVisited();
    _loadReviews();
  }

  @override
  void dispose() {
    _cantidadController.dispose();
    super.dispose();
  }

  Future<void> _markProductVisited() async {
    await visitedProductsUseCase.addProduct({
      'id': widget.product.id,
      'nombre': widget.product.titulo,
      'descripcion': widget.product.descripcion,
      'precio': widget.product.precio,
      'stock': widget.product.stock,
      'images': widget.product.images,
    });
  }

  Future<void> _loadReviews() async {
    try {
      final fetchedReviews = await productReviewsUseCase.getReviews(widget.product.id);
      setState(() {
        reviews = fetchedReviews;
        isLoadingReviews = false;
      });
    } catch (e) {
      print('Error al cargar las reviews del producto, inténtelo con otro: $e');
      setState(() {
        isLoadingReviews = false;
      });
    }
  }

  void _addToCart() async {
    final int? ingresoQuantity = int.tryParse(_cantidadController.text);

    if (ingresoQuantity == null || ingresoQuantity <= 0) {
      _showAlert("La cantidad que ingresó es inválida", "ingrese una cantidad válida o que sea mayor a cero por favor.");
      return;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cartItems = prefs.getStringList('cart') ?? [];

    bool productExists = false;

    for (int i = 0; i < cartItems.length; i++) {
      Map<String, dynamic> cartItem = jsonDecode(cartItems[i]);

      if (cartItem['nombre'] == widget.product.titulo) {
        int nuevaCantidad = cartItem['cantidad'] + ingresoQuantity;

        if (nuevaCantidad > (widget.product.stock ?? 0)) {
          _showAlert("Insuficiente Stock", "El stock no alcanza para la cantidad que desea ingresar.");
          return;
        }

        cartItem['cantidad'] = nuevaCantidad;
        cartItem['total'] = nuevaCantidad * widget.product.precio;
        cartItems[i] = jsonEncode(cartItem);
        productExists = true;
        break;
      }
    }

    if (!productExists) {
      if (cartItems.length >= 7) {
        _showAlert("El carrito está lleno", "Lo siento, no puedes agregar más de 7 productos difrentes al carrito.");
        return;
      }

      if (ingresoQuantity > (widget.product.stock ?? 0)) {
        _showAlert("Stock insuficiente", "No hay suficiente stock disponible para la cantidad que desea.");
        return;
      }

      Map<String, dynamic> newItem = {
        'nombre': widget.product.titulo,
        'cantidad': ingresoQuantity,
        'precio': widget.product.precio,
        'total': ingresoQuantity * widget.product.precio,
        'fecha': DateTime.now().toString(),
      };
      cartItems.add(jsonEncode(newItem));
    }

    await prefs.setStringList('cart', cartItems);

    _showAlert("Producto agregado", "El producto que seleccionó, se ha agregado al carrito.");
    print("Se actualizó el carrito: $cartItems");
  }

  void _showAlert(String title, String content) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String imageUrl = (widget.product.images != null && widget.product.images!.isNotEmpty)
        ? widget.product.images!.first
        : 'https://via.placeholder.com/150';

    return Scaffold(
      appBar: AppBar(
        title: Text("Detalle de producto"),
        backgroundColor: Colors.blue,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Carrito()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              imageUrl,
              width: 200,
              height: 200,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 24),
            Text(
              widget.product.titulo,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                widget.product.descripcion,
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 24),

            Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Precio: \$${widget.product.precio.toStringAsFixed(2)}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                "Stock disponible: ${widget.product.stock ?? 0}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 2),

           
            SizedBox(height: 10),
            TextField(
              controller: _cantidadController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Cantidad',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: 'Ingrese la cantidad',
              ),
            ),
            SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _addToCart,
                icon: Icon(Icons.add),
                label: Text("Agregar"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),

             isLoadingReviews
                ? CircularProgressIndicator()
                : reviews.isEmpty
                    ? Text("No hay reviews disponibles en este momento para este producto, inténtelo más tarde")
                    : Column(
                        children: reviews.map((review) {
                          return Card(
                            margin: EdgeInsets.symmetric(vertical: 8),
                            child: ListTile(
                              title: Text(review['user'] ?? 'Usuario anónimo'),
                              subtitle: Text(review['comment'] ?? 'Comentario no disponible'),
                            ),
                          );
                        }).toList(),
                      ),
          ],
          
        ),
      ),
    );
  }
}
