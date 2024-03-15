import 'package:bakery_app/features/domain/repositories/market_repository.dart';

import '../../../core/resources/data_state.dart';
import '../entities/market.dart';

class MarketUseCase {
  final MarketRepository _marketRepository;
  MarketUseCase(this._marketRepository);

  Future<DataState<List<MarketEntity>>> getAllMarkets() async {
    return _marketRepository.getAllMarkets();
  }

  Future<DataState<void>> addMarket(MarketEntity market) async {
    return _marketRepository.addMarket(market);
  }

  Future<DataState<void>> updateMarket(MarketEntity market) async {
    return _marketRepository.updateMarket(market);
  }
}
