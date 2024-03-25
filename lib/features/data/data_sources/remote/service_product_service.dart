import 'package:dio/dio.dart';
import '../../models/service_product.dart';


class ServiceProductService {
    Dio dio;
  ServiceProductService(this.dio);

  Future<Response> getAllServiceProducts() async {
    return dio.get('/api/ServiceProduct/GetAllServiceProduct');
  }

  Future<Response> addServiceProduct(ServiceProductModel serviceProduct) async {
    return dio.post('/api/ServiceProduct/AddServiceProduct',
        data: serviceProduct.toJson());
  }

  Future<Response> updateServiceProduct(ServiceProductModel serviceProduct) async {
    return dio.put('/api/ServiceProduct/UpdateServiceProduct',
        data: serviceProduct.toJson());
  }
}
