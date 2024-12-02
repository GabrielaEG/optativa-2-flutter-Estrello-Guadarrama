import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class VisitedProductsUseCase {
  Future<void> addProduct(Map<String, dynamic> product) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> visited = prefs.getStringList('visitedProducts') ?? [];

    int index = visited.indexWhere((item) => jsonDecode(item)['id'] == product['id']);

    if (index != -1) {
      Map<String, dynamic> existingProduct = jsonDecode(visited[index]);
      existingProduct['views'] = (existingProduct['views'] ?? 0) + 1;
      visited[index] = jsonEncode(existingProduct);
    } else {
      product['views'] = 1;
      visited.add(jsonEncode(product));
    }

    await prefs.setStringList('visitedProducts', visited);
  }

  Future<List<Map<String, dynamic>>> getVisitedProducts() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> visited = prefs.getStringList('visitedProducts') ?? [];

  return visited
      .map((item) => jsonDecode(item) as Map<String, dynamic>) 
      .toList();
}
}
