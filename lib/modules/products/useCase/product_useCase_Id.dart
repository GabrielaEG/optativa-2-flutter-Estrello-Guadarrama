import 'package:estrello_gabriela_examen_segundo_parcial/modules/products/domain/dto/product.dart';
import 'package:estrello_gabriela_examen_segundo_parcial/modules/products/domain/repository/product_repository.dart';

class GetProductId{
  final ProductRepository repository; 

  GetProductId(this.repository);

  Future<Product> call(int productId) async {
    return await repository.GetProductId(productId);
  }
}