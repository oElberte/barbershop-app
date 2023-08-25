import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dw_barbershop/src/core/exceptions/repository_exception.dart';
import 'package:dw_barbershop/src/core/fp/either.dart';
import 'package:dw_barbershop/src/core/fp/nil.dart';
import 'package:dw_barbershop/src/core/rest_client/rest_client.dart';
import 'package:dw_barbershop/src/models/schedule_model.dart';

import './schedule_repository.dart';

class ScheduleRepositoryImpl implements ScheduleRepository {
  final RestClient restClient;

  ScheduleRepositoryImpl({
    required this.restClient,
  });

  @override
  Future<Either<RepositoryException, Nil>> scheduleClient(
      ({
        int barbershopId,
        String clientName,
        DateTime date,
        int hour,
        int userId,
      }) scheduleData) async {
    try {
      await restClient.auth.post('/schedules', data: {
        'barbershop_id': scheduleData.barbershopId,
        'user_id': scheduleData.userId,
        'client_name': scheduleData.clientName,
        'date': scheduleData.date.toIso8601String(),
        'time': scheduleData.hour,
      });

      return Success(nil);
    } on DioException catch (e, s) {
      const errorMessage = 'Erro ao registrar agendamento';
      log(errorMessage, error: e, stackTrace: s);
      return Failure(RepositoryException(errorMessage));
    }
  }

  @override
  Future<Either<RepositoryException, List<ScheduleModel>>> findScheduleByDate(
      ({
        DateTime date,
        int userId,
      }) filter) async {
    try {
      final Response(:data) = await restClient.auth.get('/schedules', queryParameters: {
        'user_id': filter.userId,
        'date': filter.date.toIso8601String(),
      });

      final schedules = data.map<ScheduleModel>((s) => ScheduleModel.fromMap(s)).toList();
      return Success(schedules);
    } on DioException catch (e, s) {
      const errorMessage = 'Erro ao buscar agendamentos';
      log(errorMessage, error: e, stackTrace: s);
      return Failure(RepositoryException(errorMessage));
    } on ArgumentError catch (e, s) {
      const errorMessage = 'Erro ao buscar agendamentos';
      log('$errorMessage (Invalid JSON)', error: e, stackTrace: s);
      return Failure(RepositoryException(errorMessage));
    }
  }
}
