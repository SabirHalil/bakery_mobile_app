import 'package:bakery_app/core/resources/data_state.dart';
import 'package:bakery_app/features/domain/entities/added_dough_list_product.dart';
import 'package:bakery_app/features/domain/entities/dough_list.dart';
import 'package:bakery_app/features/domain/entities/dough_product_to_add.dart';
import 'package:bakery_app/features/domain/entities/product_not_added.dart';
import 'package:bakery_app/features/domain/repositories/dough_repository.dart';

class DoughUseCase {
  final DoughRepository _doughRepository;

  DoughUseCase(this._doughRepository);

  Future<DataState<List<DoughListEntity>>> getDoughListsByDate(
      DateTime date) async {
    return await _doughRepository.getDoughListsByDate(date);
  }

  Future<DataState<List<DoughAddedProductEntity>>> getDoughListProductsByListId(
      int listId) async {
    return await _doughRepository.getDoughListProductsByListId(listId);
  }

  Future<DataState<List<ProductNotAddedEntity>>> getAvailableDoughProducts(
      int listId) async {
    return await _doughRepository.getAvailableDoughProducts(listId);
  }

  Future<DataState<int>> addDoughProducts(int userId,
      List<DoughProductToAddEntity> doughListProduct, DateTime date) async {
    return await _doughRepository.addDoughProducts(
        userId, doughListProduct, date);
  }

  Future<DataState<void>> deleteDoughProductById(int id) async {
    return await _doughRepository.deleteDoughProductById(id);
  }

  Future<DataState<void>> updateDoughProduct(
      DoughProductToAddEntity doughProduct) async {
    return await _doughRepository.updateDoughProduct(doughProduct);
  }
}
