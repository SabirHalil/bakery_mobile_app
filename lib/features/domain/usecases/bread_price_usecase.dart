import 'package:bakery_app/features/domain/repositories/bread_price_repository.dart';

import '../../../core/resources/data_state.dart';
import '../entities/bread_price.dart';

class BreadPriceUseCase {
  final BreadPriceRepository _breadPriceRepository;
  BreadPriceUseCase(this._breadPriceRepository);

  Future<DataState<List<BreadPriceEntity>?>> getAllBreadPrices() async {
    return _breadPriceRepository.getAllBreadPrices();
  }

  Future<DataState<void>> addBreadPrice(BreadPriceEntity breadPrice) async {
    return _breadPriceRepository.addBreadPrice(breadPrice);
  }

  Future<DataState<void>> updateBreadPrice(BreadPriceEntity breadPrice) async {
    return _breadPriceRepository.updateBreadPrice(breadPrice);
  }
}
