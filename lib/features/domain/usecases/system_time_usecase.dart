import 'package:bakery_app/features/domain/repositories/system_time_repository.dart';

import '../../../core/resources/data_state.dart';
import '../entities/system_time.dart';

class SystemTimeUseCase {
  final SystemTimeRepository _systemTimeRepository;
  SystemTimeUseCase(this._systemTimeRepository);

  Future<DataState<SystemTimeEntity?>> getSystemTime() async {
    return _systemTimeRepository.getSystemTime();
  }

  Future<DataState<void>> updateSystemTime(SystemTimeEntity breadPrice) async {
    return _systemTimeRepository.updateSystemTime(breadPrice);
  }
}
