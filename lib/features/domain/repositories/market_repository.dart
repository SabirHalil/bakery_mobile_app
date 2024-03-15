
import '../../../core/resources/data_state.dart';
import '../entities/market.dart';

abstract class MarketRepository {
     Future<DataState<List<MarketEntity>>> getAllMarkets();
   Future<DataState<void>> addMarket(MarketEntity market);
   Future<DataState<void>> updateMarket(MarketEntity market);
}