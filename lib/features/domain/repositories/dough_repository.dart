import 'package:bakery_app/core/resources/data_state.dart';
import 'package:bakery_app/features/domain/entities/added_dough_list_product.dart';
import 'package:bakery_app/features/domain/entities/dough_list.dart';
import 'package:bakery_app/features/domain/entities/dough_product_to_add.dart';
import 'package:bakery_app/features/domain/entities/product_not_added.dart';

abstract class DoughRepository {
  Future<DataState<List<DoughListEntity>>> getDoughListsByDate(DateTime date);
  Future<DataState<List<DoughAddedProductEntity>>> getDoughListProductsByListId(
      int listId);
  Future<DataState<List<ProductNotAddedEntity>>> getAvailableDoughProducts(
      int listId); // if list id is 0 then it will retrieve all dough product else retrieve products that are not exist in this list
  Future<DataState<int>> addDoughProducts(int userId,
      List<DoughProductToAddEntity> doughListProduct, DateTime date);
  Future<DataState<void>> deleteDoughProductById(int id);
  Future<DataState<void>> updateDoughProduct(
      DoughProductToAddEntity doughProduct);
}
