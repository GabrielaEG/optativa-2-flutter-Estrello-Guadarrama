import 'package:estrello_gabriela_examen_segundo_parcial/infrastructure/app/useCase/use_case.dart';
import 'package:estrello_gabriela_examen_segundo_parcial/modules/products/domain/dto/product.dart';
import 'package:estrello_gabriela_examen_segundo_parcial/modules/products/domain/repository/product_repository.dart';


class GetCategoryUseCase implements UseCase<List<Product>, String> {
  final ProductRepository repository = ProductRepository(); 

  @override  
  Future<List<Product>> execute(String category) async {
    return await repository.execute(category);
  }
}