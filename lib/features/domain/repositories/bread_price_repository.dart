import '../../../core/resources/data_state.dart';
import '../entities/bread_price.dart';

abstract class BreadPriceRepository{
  Future<DataState<List<BreadPriceEntity>?>> getAllBreadPrices();
  Future<DataState<void>> addBreadPrice(BreadPriceEntity breadPrice);
  Future<DataState<void>> updateBreadPrice(BreadPriceEntity breadPrice);
}