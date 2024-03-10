import 'package:bakery_app/features/domain/repositories/products_process_repository.dart';

import '../../../core/resources/data_state.dart';
import '../entities/dough_product_process.dart';
import '../entities/product_process.dart';

class ProductsProcessUseCase {
  final ProductsProcessRepository _productsProcessRepository;
  ProductsProcessUseCase(this._productsProcessRepository);

  Future<DataState<List<ProductProcessEntity>>>
      getAllProductsByCategoryId(int categoryId) async {
    return _productsProcessRepository.getAllProductsByCategoryId(categoryId);
  }

  Future<DataState<void>> addProduct(ProductProcessEntity product) async {
    return _productsProcessRepository.addProduct(product);
  }

  Future<DataState<void>> updateProduct(ProductProcessEntity product) async {
    return _productsProcessRepository.updateProduct(product);
  }

  Future<DataState<List<DoughProductProcessEntity>>>
      getAllDoughProducts() async {
    return _productsProcessRepository.getAllDoughProducts();
  }

  Future<DataState<void>> addDoughProduct(
      DoughProductProcessEntity product) async {
    return _productsProcessRepository.addDoughProduct(product);
  }

  Future<DataState<void>> updateDoughProduct(
      DoughProductProcessEntity product) async {
    return _productsProcessRepository.updateDoughProduct(product);
  }
}
