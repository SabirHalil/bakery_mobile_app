import '../../../core/resources/data_state.dart';
import '../entities/service_product.dart';

abstract class ServiceProductRepository {
   Future<DataState<List<ServiceProductEntity>>> getAllServiceProducts();
   Future<DataState<void>> addServiceProduct(ServiceProductEntity serviceProduct);
   Future<DataState<void>> updateServiceProduct(ServiceProductEntity serviceProduct);
}