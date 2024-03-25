
import 'package:dio/dio.dart';
import '../../models/service_debt_detail.dart';

class ServiceDebtApiService {
    Dio dio;
  ServiceDebtApiService(this.dio);

  Future<Response> getServiceDebtMarketsList() async {
    return dio.get('/api/DebtMarket/GetDebtsOfMarkets');
  }

  Future<Response> getServiceDebtDetailByMarketId(int marketId) async {
    return dio.get('/api/DebtMarket/GetDebtByMarketId',
        queryParameters: {'marketId': marketId});
  }

  Future<Response> postServicePayDebt(ServiceDebtDetailModel serviceDebtDetail) async {
    return dio.post('/api/DebtMarket/PayDebt',
        data: serviceDebtDetail.toJson());
  }

  Future<Response> deleteServiceDebtDetail(int id) async {
    return dio.delete('/api/DebtMarket/DeleteDebtMarket',
        queryParameters: {'id': id});
  }

  Future<Response> updateServiceDebtDetail(ServiceDebtDetailModel serviceDebtDetail) async {
    return dio.put('/api/DebtMarket/UpdateDebtMarket',
        data: serviceDebtDetail.toJson());
  }
}
