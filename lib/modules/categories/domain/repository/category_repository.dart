import 'package:estrello_gabriela_examen_segundo_parcial/infrastructure/app/repository/repository.dart';
import 'package:estrello_gabriela_examen_segundo_parcial/infrastructure/connection/connection.dart';
import 'package:estrello_gabriela_examen_segundo_parcial/modules/categories/domain/dto/category.dart';

class CategoryRepository implements Repository<List<Category>, void> {
  final String _url = 'https://dummyjson.com/products/categories';

  @override  
  Future<List<Category>> execute(void params) async {
    Connection connection = Connection(); 
    final response = await connection.get<List<dynamic>>(_url);
    
    
    return response.map((e) => Category.fromJson(e as Map<String, dynamic>)).toList();
  }
}
