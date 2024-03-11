
import 'package:bakery_app/features/domain/entities/system_time.dart';

import '../../../core/resources/data_state.dart';

abstract class SystemTimeRepository{
  Future<DataState<SystemTimeEntity?>> getSystemTime();
  Future<DataState<void>> updateSystemTime(SystemTimeEntity systemTime);
}