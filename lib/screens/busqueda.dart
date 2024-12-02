import 'package:estrello_gabriela_examen_segundo_parcial/router/routers.dart';
import 'package:flutter/material.dart';
import 'package:estrello_gabriela_examen_segundo_parcial/modules/products/useCase/product_useCasse_search.dart';
import 'package:estrello_gabriela_examen_segundo_parcial/screens/productoDetallado.dart';
import 'package:estrello_gabriela_examen_segundo_parcial/modules/products/domain/dto/product.dart';
import 'package:estrello_gabriela_examen_segundo_parcial/components/NavigatorBar.dart';

class BusquedaPantalla extends StatefulWidget {
  @override
  _BusquedaPantallaState createState() => _BusquedaPantallaState();
}

class _BusquedaPantallaState extends State<BusquedaPantalla> {
  final TextEditingController _searchController = TextEditingController();
  final ProductSearchUseCase _searchUseCase = ProductSearchUseCase();
  List<Product> _searchResults = [];
  bool _isLoading = false;

  Future<void> _performSearch(String query) async {
    if (query.isEmpty) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final results = await _searchUseCase.searchProducts(query);
      setState(() {
        _searchResults = results;
      });
    } catch (e) {
      print('Error al buscar productos, vuelvalo a intentar: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al buscar productos, inténtelo de nuevo')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _onNavBarTap(int index) {
    switch (index) {
      case 0:
        break; 
      case 1:
        Navigator.pushNamed(context, Routers.carrito);
        break;
      case 2:
        Navigator.pushNamed(context, Routers.visitado);
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
        title: Text("Buscar Productos"),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Buscar...',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () => _performSearch(_searchController.text),
                ),
              ),
              onSubmitted: _performSearch,
            ),
          ),
          if (_isLoading)
            Center(child: CircularProgressIndicator())
          else if (_searchResults.isEmpty)
            Expanded(child: Center(child: Text('No hay resultados encontrados')))
          else
            Expanded(
              child: ListView.builder(
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  final product = _searchResults[index];
                  return ListTile(
                    leading: Image.network(
                      (product.images != null && product.images!.isNotEmpty)
                          ? product.images!.first
                          : 'https://via.placeholder.com/150',
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(product.titulo),
                    subtitle: Text("\$${product.precio.toStringAsFixed(2)}"),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductoDetallado(product: product),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
        ],
      ),
      bottomNavigationBar: CustomNavigationBar(
        currentIndex: 0, 
        onTap: _onNavBarTap,
      ),
    );
  }
}
