import 'package:flutter/material.dart';
import 'package:estrello_gabriela_examen_segundo_parcial/modules/categories/domain/dto/category.dart';
import 'package:estrello_gabriela_examen_segundo_parcial/modules/categories/useCase/categories_usecase.dart';
import 'package:estrello_gabriela_examen_segundo_parcial/screens/productosCategoría.dart';

class CategoryScreen extends StatelessWidget {
  final GetUseCaseCategory _useCase = GetUseCaseCategory();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Categorías"),
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: FutureBuilder<List<Category>>(
        future: _useCase.execute(null),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No hay categorías disponibles"));
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
    );
  }
}
