import 'dart:convert';
import 'package:http/http.dart' as http;

class ProductReviewsUseCase {
  Future<List<Map<String, dynamic>>> getReviews(int productId) async {
    final response = await http.get(Uri.parse('https://dummyjson.com/products/$productId'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      
      if (data.containsKey('reviews')) {
        return List<Map<String, dynamic>>.from(data['reviews']);
      } else {
        return [];
      }
    } else {
      throw Exception('Error al obtener las reviews del producto');
    }
  }
}
