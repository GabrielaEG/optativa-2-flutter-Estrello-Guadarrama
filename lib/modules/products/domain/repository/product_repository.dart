import 'package:estrello_gabriela_examen_segundo_parcial/infrastructure/app/repository/repository.dart';
import 'package:estrello_gabriela_examen_segundo_parcial/infrastructure/connection/connection.dart';
import 'package:estrello_gabriela_examen_segundo_parcial/modules/products/domain/dto/product.dart';

class ProductRepository implements Repository<List<Product>, String> {
  final String _baseUrl = 'https://dummyjson.com/products';

  @override
  Future<List<Product>> execute(String category) async {
    Connection connection = Connection();
    final response = await connection.get<Map<String, dynamic>>('$_baseUrl/category/$category');
    List productsData = response['products'] ?? [];
    return productsData.map((data) => Product.fromJson(data)).toList();
  }

  Future<Product> GetProductId(int productId) async {
    Connection connection = Connection();
    final response = await connection.get<Map<String, dynamic>>('$_baseUrl/$productId');
    return Product.fromJson(response);
  }
}