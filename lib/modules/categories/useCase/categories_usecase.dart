import 'package:estrello_gabriela_examen_segundo_parcial/infrastructure/app/useCase/use_case.dart';
import 'package:estrello_gabriela_examen_segundo_parcial/modules/categories/domain/dto/category.dart';
import 'package:estrello_gabriela_examen_segundo_parcial/modules/categories/domain/repository/category_repository.dart';


class GetUseCaseCategory implements UseCase<List<Category>, void>{
  final CategoryRepository repository = CategoryRepository(); 

  @override
  Future<List<Category>> execute(void params) async {
    return await repository.execute(null);
  }
}