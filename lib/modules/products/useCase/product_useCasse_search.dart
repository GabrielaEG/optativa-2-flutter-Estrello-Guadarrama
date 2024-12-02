import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:estrello_gabriela_examen_segundo_parcial/modules/products/domain/dto/product.dart';

class ProductSearchUseCase {
  Future<List<Product>> searchProducts(String query) async {
    final url = Uri.parse('https://dummyjson.com/products/search?q=$query');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final products = List<Map<String, dynamic>>.from(data['products'] ?? []);
      return products.map((product) => Product.fromJson(product)).toList();
    } else {
      throw Exception('Error al buscar los productos');
    }
  }
}
