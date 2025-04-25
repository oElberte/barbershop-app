import 'package:barbershop/src/core/exceptions/repository_exception.dart';
import 'package:barbershop/src/core/fp/either.dart';
import 'package:barbershop/src/core/providers/application_providers.dart';
import 'package:barbershop/src/models/schedule_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'employee_schedule_vm.g.dart';

@riverpod
class EmployeeScheduleVm extends _$EmployeeScheduleVm {
  Future<Either<RepositoryException, List<ScheduleModel>>> _getSchedules(
      int userId, DateTime date) async {
    final repository = ref.read(scheduleRepositoryProvider);
    return await repository.findScheduleByDate((userId: userId, date: date));
  }

  @override
  Future<List<ScheduleModel>> build(int userId, DateTime date) async {
    final scheduleListResult = await _getSchedules(userId, date);

    return switch (scheduleListResult) {
      Failure(:final exception) => throw Exception(exception),
      Success(value: final schedules) => schedules,
    };
  }

  Future<void> changeDate(int userId, DateTime date) async {
    final scheduleListResult = await _getSchedules(userId, date);

    state = switch (scheduleListResult) {
      Failure(:final exception) =>
        AsyncError(Exception(exception), StackTrace.current),
      Success(value: final schedules) => AsyncData(schedules),
    };
  }
}
