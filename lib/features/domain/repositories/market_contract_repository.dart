import '../../../core/resources/data_state.dart';
import '../entities/market.dart';
import '../entities/market_contract.dart';

abstract class MarketContractRepository {
   Future<DataState<List<MarketContractEntity>>> getAllMarketContracts();
   Future<DataState<List<MarketEntity>>> getMarketsNotHaveContracts();
   Future<DataState<void>> addMarketContract(MarketContractEntity marketContract);
   Future<DataState<void>> updateMarketContract(MarketContractEntity marketContract);
}