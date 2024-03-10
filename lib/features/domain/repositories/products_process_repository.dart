import '../../../core/resources/data_state.dart';
import '../entities/dough_product_process.dart';
import '../entities/product_process.dart';

abstract class ProductsProcessRepository {
   Future<DataState<List<ProductProcessEntity>>>getAllProductsByCategoryId();
   Future<DataState<String?>> addProduct(ProductProcessEntity product);
   Future<DataState<String?>> updateProduct(ProductProcessEntity product);

   Future<DataState<List<DoughProductProcessEntity>>>getAllDoughProducts();
   Future<DataState<String?>> addDoughProduct(DoughProductProcessEntity product);
   Future<DataState<String?>> updateDoughProduct(DoughProductProcessEntity product);
}
