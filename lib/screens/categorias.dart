import 'package:flutter/material.dart';
import 'package:estrello_gabriela_examen_segundo_parcial/modules/categories/domain/dto/category.dart';
import 'package:estrello_gabriela_examen_segundo_parcial/modules/categories/useCase/categories_usecase.dart';
import 'package:estrello_gabriela_examen_segundo_parcial/screens/productosCategoría.dart';
import 'package:estrello_gabriela_examen_segundo_parcial/router/routers.dart';
import 'package:estrello_gabriela_examen_segundo_parcial/components/NavigatorBar.dart';

class CategoriaPantalla extends StatelessWidget {
  final GetUseCaseCategory _useCase = GetUseCaseCategory();

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
        Navigator.pushNamed(context, Routers.pefil);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Categorías"),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, Routers.carrito);
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Category>>(
        future: _useCase.execute(null),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("Las categorías no se encuentran disponibles por el momento"));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final category = snapshot.data![index];

                final iconData = index % 2 == 0 ? Icons.shopping_bag : Icons.fastfood;
                final iconColor = index % 2 == 0 ? Colors.blue : Colors.red;
                final arrowColor = index % 2 == 0 ? Colors.blue : Colors.red;

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
                  child: ListTile(
                    leading: Icon(iconData, color: iconColor),
                    title: Text(
                      category.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    subtitle: Text(
                      "2024-12-01 13:45:06.000", 
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios, color: arrowColor),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductosCategoria(categorySlug: category.slug),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
      bottomNavigationBar: CustomNavigationBar(
        currentIndex: 1, 
        onTap: (index) => _onNavBarTap(context, index),
      ),
    );
  }
}
