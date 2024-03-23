import 'package:bakery_app/features/domain/usecases/service_stale_product_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/resources/data_state.dart';
import '../../../../../../core/utils/toast_message.dart';
import '../../../../../data/models/service_stale_product.dart';

part 'service_stale_product_event.dart';
part 'service_stale_product_state.dart';

class ServiceStaleProductBloc
    extends Bloc<ServiceStaleProductEvent, ServiceStaleProductState> {
  final ServiceStaleProductUseCase _serviceStaleProductUseCase;
  ServiceStaleProductBloc(this._serviceStaleProductUseCase) : super(const ServiceStaleProductLoading()) {
    on<ServiceStaleProductGetListRequested>(onGetServiceStaleProductList);
    on<ServiceStaleProductPostRequested>(onPostServiceStaleProduct);
    on<ServiceStaleProductUpdateRequested>(onUpdateServiceStaleProduct);
    on<ServiceStaleProductDeleteRequested>(onDeleteServiceStaleProduct);

  }

  void onGetServiceStaleProductList(ServiceStaleProductGetListRequested event,
      Emitter<ServiceStaleProductState> emit) async {
    emit(const ServiceStaleProductLoading());
    final dataState =
        await _serviceStaleProductUseCase.getServiceStaleProductListByDateAndServiceType(
            event.date, event.serviceTypeId);
    if (dataState is DataSuccess) {
      emit(ServiceStaleProductSuccess(
          serviceStaleProductList:
              dataState.data as List<ServiceStaleProductModel>));
    }

    if (dataState is DataFailed) {
      emit(ServiceStaleProductFailure(error: dataState.error!.message));
    }
  }

 void onPostServiceStaleProduct(
      ServiceStaleProductPostRequested event, Emitter<ServiceStaleProductState> emit) async {
    final state = this.state;
    emit(const ServiceStaleProductLoading());

    final dataState = await _serviceStaleProductUseCase.addServiceStaleProduct(event.serviceStaleProduct);

    if (dataState is DataSuccess) {
      emit(ServiceStaleProductSuccess(serviceStaleProductList: [...?state.serviceStaleProductList, event.serviceStaleProduct]));
      showToastMessage('Bayat başarıyla eklendi');
    }

    if (dataState is DataFailed) {
      emit(ServiceStaleProductFailure(error: dataState.error!.message));
    }
  }

    void onUpdateServiceStaleProduct(
      ServiceStaleProductUpdateRequested event, Emitter<ServiceStaleProductState> emit) async {
    final state = this.state;
    emit(const ServiceStaleProductLoading());
    final dataState = await _serviceStaleProductUseCase.updateServiceStaleProduct(event.serviceStaleProduct);

    if (dataState is DataSuccess) {
      emit(ServiceStaleProductSuccess(serviceStaleProductList: [
        ...state.serviceStaleProductList!.map((element) =>
            element.id == event.serviceStaleProduct.id ? event.serviceStaleProduct : element)
      ]));
      showToastMessage('Bayat başarıyla güncellendi');
    }

    if (dataState is DataFailed) {
      emit(ServiceStaleProductFailure(error: dataState.error!.message));
    }
  }

   void onDeleteServiceStaleProduct(
      ServiceStaleProductDeleteRequested event, Emitter<ServiceStaleProductState> emit) async {
    final state = this.state;
    emit(const ServiceStaleProductLoading());

    final dataState = await _serviceStaleProductUseCase.deleteServiceStaleProduct(event.serviceStaleProduct.id);

    if (dataState is DataSuccess) {
      emit(ServiceStaleProductSuccess(
          serviceStaleProductList: [...?state.serviceStaleProductList]..remove(event.serviceStaleProduct)));
          showToastMessage('Bayat başarıyla silindi');
    }

    if (dataState is DataFailed) {
      emit(ServiceStaleProductFailure(error: dataState.error!.message));
    }
  }


}
