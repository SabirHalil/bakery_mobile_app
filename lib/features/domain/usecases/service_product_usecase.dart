import '../../../core/resources/data_state.dart';
import '../entities/service_product.dart';
import '../repositories/service_product_repository.dart';

class ServiceProductUseCase {
  final ServiceProductRepository _serviceProductRepository;
  ServiceProductUseCase(this._serviceProductRepository);

  Future<DataState<List<ServiceProductEntity>>> getAllServiceProducts() async {
    return _serviceProductRepository.getAllServiceProducts();
  }

  Future<DataState<void>> addServiceProduct(ServiceProductEntity serviceProduct) async {
    return _serviceProductRepository.addServiceProduct(serviceProduct);
  }

  Future<DataState<void>> updateServiceProduct(ServiceProductEntity serviceProduct) async {
    return _serviceProductRepository.updateServiceProduct(serviceProduct);
  }
}
