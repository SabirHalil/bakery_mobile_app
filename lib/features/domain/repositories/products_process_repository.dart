import '../../../core/resources/data_state.dart';
import '../entities/dough_product_process.dart';
import '../entities/product_process.dart';

abstract class ProductsProcessRepository {
   Future<DataState<List<ProductProcessEntity>>> getAllProductsByCategoryId(int categoryId);
   Future<DataState<void>> addProduct(ProductProcessEntity product);
   Future<DataState<void>> updateProduct(ProductProcessEntity product);

   Future<DataState<List<DoughProductProcessEntity>>> getAllDoughProducts();
   Future<DataState<void>> addDoughProduct(DoughProductProcessEntity product);
   Future<DataState<void>> updateDoughProduct(DoughProductProcessEntity product);
}
