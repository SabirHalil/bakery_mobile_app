import '../../../core/resources/data_state.dart';
import '../entities/market_contract.dart';
import '../repositories/market_contract_repository.dart';

class MarketContractUseCase {
  final MarketContractRepository _marketContractRepository;
  MarketContractUseCase(this._marketContractRepository);

  Future<DataState<List<MarketContractEntity>>> getAllMarketContracts() async {
    return _marketContractRepository.getAllMarketContracts();
  }

  Future<DataState<void>> addMarketContract(MarketContractEntity marketContract) async {
    return _marketContractRepository.addMarketContract(marketContract);
  }

  Future<DataState<void>> updateMarketContract(MarketContractEntity marketContract) async {
    return _marketContractRepository.updateMarketContract(marketContract);
  }
}
