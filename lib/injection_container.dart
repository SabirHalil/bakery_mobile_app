// ignore_for_file: depend_on_referenced_packages

import 'package:bakery_app/core/constants/constants.dart';
import 'package:bakery_app/features/data/data_sources/remote/auth_service.dart';
import 'package:bakery_app/features/data/data_sources/remote/dough_service.dart';
import 'package:bakery_app/features/data/data_sources/remote/expense_service.dart';
import 'package:bakery_app/features/data/data_sources/remote/given_product_to_service_service.dart';
import 'package:bakery_app/features/data/data_sources/remote/product_service.dart';
import 'package:bakery_app/features/data/data_sources/remote/products_process_service.dart';
import 'package:bakery_app/features/data/data_sources/remote/service_account_service.dart';
import 'package:bakery_app/features/data/data_sources/remote/service_debt_service.dart';
import 'package:bakery_app/features/data/data_sources/remote/service_services_service.dart';
import 'package:bakery_app/features/data/data_sources/remote/stale_bread_service.dart';
import 'package:bakery_app/features/data/repositories/auth_repository_impl.dart';
import 'package:bakery_app/features/data/repositories/dough_repository_impl.dart';
import 'package:bakery_app/features/data/repositories/product_repository_impl.dart';
import 'package:bakery_app/features/data/repositories/service_account_repository_impl.dart';
import 'package:bakery_app/features/domain/repositories/auth_repository.dart';
import 'package:bakery_app/features/domain/repositories/dough_repository.dart';
import 'package:bakery_app/features/domain/repositories/expense_repository.dart';
import 'package:bakery_app/features/domain/repositories/product_repository.dart';
import 'package:bakery_app/features/domain/repositories/service_account_repository.dart';
import 'package:bakery_app/features/domain/repositories/service_market_repository.dart';
import 'package:bakery_app/features/domain/usecases/dough_factory_usecases.dart';
import 'package:bakery_app/features/domain/usecases/expense_usecase.dart';
import 'package:bakery_app/features/domain/usecases/given_product_to_service_usecase.dart';
import 'package:bakery_app/features/domain/usecases/product_usecase.dart';
import 'package:bakery_app/features/domain/usecases/service_account_usecases.dart';
import 'package:bakery_app/features/domain/usecases/service_market_usecase.dart';
import 'package:bakery_app/features/domain/usecases/stale_product_usecase.dart';
import 'package:bakery_app/features/domain/usecases/user_login_usecase.dart';
import 'package:bakery_app/features/presentation/pages/admin/bloc/pdf/pdf_bloc.dart';
import 'package:bakery_app/features/presentation/pages/sell_assistance/bloc/bread_counting/bread_counting_bloc.dart';
import 'package:bakery_app/features/presentation/pages/sell_assistance/bloc/given_product_to_service/given_product_to_service_bloc.dart';
import 'package:bakery_app/features/presentation/pages/sell_assistance/bloc/service_stale_product/service_stale_product_bloc.dart';
import 'package:bakery_app/features/presentation/pages/service/bloc/service_account_left/service_account_left_bloc.dart';
import 'package:bakery_app/features/presentation/pages/service/bloc/service_added_markets/service_added_markets_bloc.dart';
import 'package:bakery_app/features/presentation/pages/service/bloc/service_lists/service_lists_bloc.dart';
import 'package:bakery_app/features/presentation/pages/service/bloc/service_markets/service_markets_bloc.dart';
import 'package:bakery_app/features/presentation/pages/service/bloc/service_stale_left/service_stale_left_bloc.dart';
import 'package:bakery_app/features/presentation/pages/service/bloc/service_stale_received/service_stale_received_bloc.dart';
import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

import 'features/data/data_sources/remote/bread_counting_service.dart';
import 'features/data/data_sources/remote/bread_price_service.dart';
import 'features/data/data_sources/remote/cash_counting_service.dart';
import 'features/data/data_sources/remote/pdf_service.dart';
import 'features/data/data_sources/remote/product_counting_service.dart';
import 'features/data/data_sources/remote/received_money_from_service_service.dart';
import 'features/data/data_sources/remote/service_stale_product_service.dart';
import 'features/data/data_sources/remote/service_stale_service.dart';
import 'features/data/data_sources/remote/stale_product_service.dart';
import 'features/data/data_sources/remote/system_time_service.dart';
import 'features/data/repositories/bread_counting_repository_impl.dart';
import 'features/data/repositories/bread_price_repository_impl.dart';
import 'features/data/repositories/cash_counting_repository_impl.dart';
import 'features/data/repositories/expense_repository_impl.dart';
import 'features/data/repositories/given_product_to_service_repository_impl.dart';
import 'features/data/repositories/pdf_repository_impl.dart';
import 'features/data/repositories/product_counting_repository_impl.dart';
import 'features/data/repositories/products_process_repository_impl.dart';
import 'features/data/repositories/received_money_from_service_repository_impl.dart';
import 'features/data/repositories/service_debt_repository_impl.dart';
import 'features/data/repositories/service_market_repository_impl.dart';
import 'features/data/repositories/service_stale_product_repository_impl.dart';
import 'features/data/repositories/service_stale_repository_impl.dart';
import 'features/data/repositories/stale_bread_repository_impl.dart';
import 'features/data/repositories/stale_product_repository_impl.dart';
import 'features/data/repositories/system_time_repository_impl.dart';
import 'features/domain/repositories/bread_counting_repository.dart';
import 'features/domain/repositories/bread_price_repository.dart';
import 'features/domain/repositories/cash_counting_repository.dart';
import 'features/domain/repositories/given_product_to_service_repository.dart';
import 'features/domain/repositories/pdf_repository.dart';
import 'features/domain/repositories/product_counting_repository.dart';
import 'features/domain/repositories/products_process_repository.dart';
import 'features/domain/repositories/received_money_from_service_repository.dart';
import 'features/domain/repositories/service_debt_repository.dart';
import 'features/domain/repositories/service_stale_product_repository.dart';
import 'features/domain/repositories/service_stale_repository.dart';
import 'features/domain/repositories/stale_bread_repository.dart';
import 'features/domain/repositories/stale_product_repository.dart';
import 'features/domain/repositories/system_time_repository.dart';
import 'features/domain/usecases/bread_counting_usecase.dart';
import 'features/domain/usecases/bread_price_usecase.dart';
import 'features/domain/usecases/cash_counting_usecase.dart';
import 'features/domain/usecases/pdf_usecase.dart';
import 'features/domain/usecases/product_counting_usecase.dart';
import 'features/domain/usecases/products_process_usecase.dart';
import 'features/domain/usecases/received_money_from_service_usecase.dart';
import 'features/domain/usecases/service_debt_usecase.dart';
import 'features/domain/usecases/service_stale_product_usecase.dart';
import 'features/domain/usecases/service_stale_usecase.dart';
import 'features/domain/usecases/stale_bread_usecase.dart';
import 'features/domain/usecases/system_time_usecase.dart';
import 'features/presentation/pages/admin/bloc/bread_price/bread_price_bloc.dart';
import 'features/presentation/pages/admin/bloc/dough_products_process/dough_products_process_bloc.dart';
import 'features/presentation/pages/admin/bloc/products_process/products_process_bloc.dart';
import 'features/presentation/pages/admin/bloc/system_time/system_time_bloc.dart';
import 'features/presentation/pages/auth/bloc/auth_bloc.dart';
import 'features/presentation/pages/dough/bloc/dough_added_products/dough_added_products_bloc.dart';
import 'features/presentation/pages/dough/bloc/dough_lists/dough_factory_bloc.dart';
import 'features/presentation/pages/dough/bloc/dough_products/dough_products_bloc.dart';
import 'features/presentation/pages/production/bloc/added_products/added_product_bloc.dart';
import 'features/presentation/pages/production/bloc/products/product_bloc.dart';
import 'features/presentation/pages/sell_assistance/bloc/expense/expense_bloc.dart';
import 'features/presentation/pages/sell_assistance/bloc/product_counting_added/product_counting_added_bloc.dart';
import 'features/presentation/pages/sell_assistance/bloc/product_counting_not_added/product_counting_not_added_bloc.dart';
import 'features/presentation/pages/sell_assistance/bloc/received_money_from_service/received_money_from_service_bloc.dart';
import 'features/presentation/pages/sell_assistance/bloc/stale_bread/stale_bread_bloc.dart';
import 'features/presentation/pages/sell_assistance/bloc/stale_bread_products/stale_bread_products_bloc.dart';
import 'features/presentation/pages/sell_assistance/bloc/stale_product/stale_product_bloc.dart';
import 'features/presentation/pages/sell_assistance/bloc/stale_product_products/stale_product_products_bloc.dart';
import 'features/presentation/pages/service/bloc/service_account_received/service_account_received_bloc.dart';
import 'features/presentation/pages/service/bloc/service_debt/service_debt_bloc.dart';
import 'features/presentation/pages/service/bloc/service_debt_detail/service_debt_detail_bloc.dart';

final sl = GetIt.instance;
Future<void> initializeDependencies() async {
  // Dio
  sl.registerSingleton<Dio>(Dio());
  sl.registerSingleton<String>(baseUrl);
  sl.registerLazySingleton(() => GlobalKey<NavigatorState>());
  // Dependencies
  //sl.registerSingleton<Api>(Api());
  sl.registerSingleton<AuthApiService>(AuthApiService(sl(), sl()));
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl(sl()));
  sl.registerSingleton<DoughApiService>(DoughApiService(sl(), sl()));
  sl.registerSingleton<DoughRepository>(DoughRepositoryImpl(sl()));
  sl.registerSingleton<ProductApiService>(ProductApiService(sl(), sl()));
  sl.registerSingleton<ProductRepository>(ProductRepositoryImpl(sl()));
  sl.registerSingleton<ServiceServicesApiService>(
      ServiceServicesApiService(sl(), sl()));
  sl.registerSingleton<ServiceMarketRepository>(
      ServiceMarketRepositoryImpl(sl()));
  sl.registerSingleton<ServiceAccountService>(
      ServiceAccountService(sl(), sl()));
  sl.registerSingleton<ServiceAccountRepository>(
      ServiceAccountRepositoryImpl(sl()));
  sl.registerSingleton<ServiceStaleService>(ServiceStaleService(sl(), sl()));
  sl.registerSingleton<ServiceStaleRepository>(
      ServiceStaleRepositoryImpl(sl()));
  sl.registerSingleton<ServiceDebtApiService>(
      ServiceDebtApiService(sl(), sl()));
  sl.registerSingleton<ServiceDebtRepository>(ServiceDebtRepositoryImpl(sl()));
  sl.registerSingleton<ExpenseService>(ExpenseService(sl(), sl()));
  sl.registerSingleton<ExpenseRepository>(ExpenseRepositoryImpl(sl()));
  sl.registerSingleton<GivenProductToService>(
      GivenProductToService(sl(), sl()));
  sl.registerSingleton<GivenProductToServiceRepository>(
      GivenProductToServiceRepositoryImpl(sl()));
  sl.registerSingleton<ServiceStaleProduct>(ServiceStaleProduct(sl(), sl()));
  sl.registerSingleton<ServiceStaleProductRepository>(
      ServiceStaleProductRepositoryImpl(sl()));
  sl.registerSingleton<StaleBreadService>(StaleBreadService(sl(), sl()));
  sl.registerSingleton<StaleBreadRepository>(StaleBreadRepositoryImpl(sl()));
  sl.registerSingleton<StaleProductService>(StaleProductService(sl(), sl()));
  sl.registerSingleton<StaleProductRepository>(
      StaleProductRepositoryImpl(sl()));
  sl.registerSingleton<ReceivedMoneyFromService>(
      ReceivedMoneyFromService(sl(), sl()));
  sl.registerSingleton<ReceivedMoneyFromServiceRepository>(
      ReceivedMoneyFromServiceRepositoryImpl(sl()));
  sl.registerSingleton<BreadCountingService>(BreadCountingService(sl(), sl()));
  sl.registerSingleton<BreadCountingRepository>(
      BreadCountingRepositoryImpl(sl()));
  sl.registerSingleton<ProductCountingService>(
      ProductCountingService(sl(), sl()));
  sl.registerSingleton<ProductCountingRepository>(
      ProductCountingRepositoryImpl(sl()));
  sl.registerSingleton<CashCountingService>(CashCountingService(sl(), sl()));
  sl.registerSingleton<CashCountingRepository>(
      CashCountingRepositoryImpl(sl()));
  sl.registerSingleton<PdfService>(PdfService(sl(), sl()));
  sl.registerSingleton<PdfRepository>(PdfRepositoryImpl(sl()));

  sl.registerSingleton<ProductsProcessService>(
      ProductsProcessService(sl(), sl()));
  sl.registerSingleton<ProductsProcessRepository>(
      ProductsProcessRepositoryImpl(sl()));

  sl.registerSingleton<BreadPriceService>(BreadPriceService(sl(), sl()));
  sl.registerSingleton<BreadPriceRepository>(BreadPriceRepositoryImpl(sl()));

  sl.registerSingleton<SystemTimeService>(SystemTimeService(sl(), sl()));
  sl.registerSingleton<SystemTimeRepository>(SystemTimeRepositoryImpl(sl()));

  // Usecases
  sl.registerSingleton<AuthUseCase>(AuthUseCase(sl()));
  sl.registerSingleton<DoughUseCase>(DoughUseCase(sl()));
  sl.registerSingleton<ProductUseCase>(ProductUseCase(sl()));
  sl.registerSingleton<ServiceMarketUseCase>(ServiceMarketUseCase(sl()));
  sl.registerSingleton<ServiceAccountUseCase>(ServiceAccountUseCase(sl()));
  sl.registerSingleton<ServiceStaleUseCase>(ServiceStaleUseCase(sl()));
  sl.registerSingleton<ServiceDebtUseCase>(ServiceDebtUseCase(sl()));
  sl.registerSingleton<ExpenseUseCase>(ExpenseUseCase(sl()));
  sl.registerSingleton<GivenProductToServiceUseCase>(
      GivenProductToServiceUseCase(sl()));
  sl.registerSingleton<ServiceStaleProductUseCase>(
      ServiceStaleProductUseCase(sl()));
  sl.registerSingleton<StaleBreadUseCase>(StaleBreadUseCase(sl()));
  sl.registerSingleton<StaleProductUseCase>(StaleProductUseCase(sl()));
  sl.registerSingleton<ReceivedMoneyFromServiceUseCase>(
      ReceivedMoneyFromServiceUseCase(sl()));
  sl.registerSingleton<BreadCountingUseCase>(BreadCountingUseCase(sl()));
  sl.registerSingleton<ProductCountingUseCase>(ProductCountingUseCase(sl()));
  sl.registerSingleton<CashCountingUseCase>(CashCountingUseCase(sl()));
  sl.registerSingleton<PdfUseCase>(PdfUseCase(sl()));
  sl.registerSingleton<ProductsProcessUseCase>(ProductsProcessUseCase(sl()));
  sl.registerSingleton<BreadPriceUseCase>(BreadPriceUseCase(sl()));
  sl.registerSingleton<SystemTimeUseCase>(SystemTimeUseCase(sl()));

  // Blocs
  sl.registerFactory<AuthBloc>(() => AuthBloc(sl()));
  sl.registerFactory<DoughFactoryBloc>(() => DoughFactoryBloc(sl()));
  sl.registerFactory<DoughAddedProductsBloc>(
      () => DoughAddedProductsBloc(sl()));
  sl.registerFactory<DoughProductsBloc>(() => DoughProductsBloc(sl()));
  sl.registerFactory<ProductBloc>(() => ProductBloc(sl()));
  sl.registerFactory<AddedProductBloc>(() => AddedProductBloc(sl()));
  sl.registerFactory<ServiceListsBloc>(() => ServiceListsBloc(sl()));
  sl.registerFactory<ServiceMarketsBloc>(() => ServiceMarketsBloc(sl()));
  sl.registerFactory<ServiceAddedMarketsBloc>(
      () => ServiceAddedMarketsBloc(sl()));
  sl.registerFactory<ServiceAccountLeftBloc>(
      () => ServiceAccountLeftBloc(sl()));
  sl.registerFactory<ServiceAccountReceivedBloc>(
      () => ServiceAccountReceivedBloc(sl()));
  sl.registerFactory<ServiceStaleLeftBloc>(() => ServiceStaleLeftBloc(sl()));
  sl.registerFactory<ServiceStaleReceivedBloc>(
      () => ServiceStaleReceivedBloc(sl()));
  sl.registerFactory<ServiceDebtBloc>(() => ServiceDebtBloc(sl()));
  sl.registerFactory<ServiceDebtDetailBloc>(() => ServiceDebtDetailBloc(sl()));
  sl.registerFactory<ExpenseBloc>(() => ExpenseBloc(sl()));
  sl.registerFactory<GivenProductToServiceBloc>(
      () => GivenProductToServiceBloc(sl()));
  sl.registerFactory<ServiceStaleProductBloc>(
      () => ServiceStaleProductBloc(sl()));
  sl.registerFactory<StaleBreadBloc>(() => StaleBreadBloc(sl()));
  sl.registerFactory<StaleBreadProductsBloc>(
      () => StaleBreadProductsBloc(sl()));
  sl.registerFactory<StaleProductBloc>(() => StaleProductBloc(sl()));
  sl.registerFactory<StaleProductProductsBloc>(
      () => StaleProductProductsBloc(sl()));
  sl.registerFactory<ReceivedMoneyFromServiceBloc>(
      () => ReceivedMoneyFromServiceBloc(sl()));
  sl.registerFactory<BreadCountingBloc>(() => BreadCountingBloc(sl()));
  sl.registerFactory<ProductCountingAddedBloc>(
      () => ProductCountingAddedBloc(sl()));
  sl.registerFactory<ProductCountingNotAddedBloc>(
      () => ProductCountingNotAddedBloc(sl()));
  sl.registerFactory<PdfBloc>(() => PdfBloc(sl()));
  sl.registerFactory<DoughProductsProcessBloc>(
      () => DoughProductsProcessBloc(sl()));
  sl.registerFactory<ProductsProcessBloc>(() => ProductsProcessBloc(sl()));
  sl.registerFactory<BreadPriceBloc>(() => BreadPriceBloc(sl()));
  sl.registerFactory<SystemTimeBloc>(() => SystemTimeBloc(sl()));
}
