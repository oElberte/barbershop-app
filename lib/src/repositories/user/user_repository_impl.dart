import 'dart:developer';
import 'dart:io';

import 'package:barbershop/src/core/exceptions/auth_exception.dart';
import 'package:barbershop/src/core/exceptions/repository_exception.dart';
import 'package:barbershop/src/core/fp/either.dart';
import 'package:barbershop/src/core/fp/nil.dart';
import 'package:barbershop/src/core/rest_client/rest_client.dart';
import 'package:barbershop/src/models/user_model.dart';
import 'package:dio/dio.dart';

import './user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final RestClient restClient;

  UserRepositoryImpl({required this.restClient});

  @override
  Future<Either<AuthException, String>> login(
      String email, String password) async {
    try {
      final Response(:data) = await restClient.unAuth.post(
        '/auth',
        data: {
          'email': email,
          'password': password,
        },
      );

      return Success(data['access_token']);
    } on DioException catch (e, s) {
      if (e.response?.statusCode == HttpStatus.forbidden) {
        log('Usuário ou senha inválidos', error: e, stackTrace: s);
        return Failure(AuthUnauthorizedException());
      }

      log('Erro ao realizar login', error: e, stackTrace: s);
      return Failure(AuthError('Erro ao realizar login'));
    }
  }

  @override
  Future<Either<RepositoryException, UserModel>> me() async {
    try {
      final Response(:data) = await restClient.auth.get('/me');
      return Success(UserModel.fromMap(data));
    } on DioException catch (e, s) {
      const errorMessage = 'Erro ao buscar usuário logado';
      log(errorMessage, error: e, stackTrace: s);
      return Failure(RepositoryException(errorMessage));
    } on ArgumentError catch (e, s) {
      log('Invalid Json', error: e, stackTrace: s);
      return Failure(RepositoryException(e.message));
    }
  }

  @override
  Future<Either<RepositoryException, Nil>> registerAdmin(
    ({
      String email,
      String name,
      String password,
    }) userData,
  ) async {
    try {
      await restClient.unAuth.post('/users', data: {
        'name': userData.name,
        'email': userData.email,
        'password': userData.password,
        'profile': 'ADM',
      });

      return Success(nil);
    } on DioException catch (e, s) {
      const errorMessage = 'Erro ao registrar usuário administrador';
      log(errorMessage, error: e, stackTrace: s);
      return Failure(RepositoryException(errorMessage));
    }
  }

  @override
  Future<Either<RepositoryException, List<UserModel>>> getEmployees(
      int barbershopId) async {
    try {
      final Response(:List data) = await restClient.auth.get(
        '/users',
        queryParameters: {'barbershop_id': barbershopId},
      );

      final employess = data.map((e) => UserModelEmployee.fromMap(e)).toList();
      return Success(employess);
    } on DioException catch (e, s) {
      const errorMessage = 'Erro ao buscar colabores';
      log(errorMessage, error: e, stackTrace: s);
      return Failure(RepositoryException(errorMessage));
    } on ArgumentError catch (e, s) {
      const errorMessage = 'Erro ao buscar colabores';
      log('$errorMessage (Invalid JSON)', error: e, stackTrace: s);
      return Failure(RepositoryException(errorMessage));
    }
  }

  @override
  Future<Either<RepositoryException, Nil>> registerAdmAsEmployee(
      ({
        List<String> workDays,
        List<int> workHours,
      }) userModel) async {
    try {
      final userModelResult = await me();

      final int userId;

      switch (userModelResult) {
        case Failure(:var exception):
          return Failure(exception);
        case Success(value: UserModel(:var id)):
          userId = id;
      }

      await restClient.auth.put('/users/$userId', data: {
        'work_days': userModel.workDays,
        'work_hours': userModel.workHours,
      });

      return Success(nil);
    } on DioException catch (e, s) {
      const errorMessage =
          'Erro ao registrar usuário administrador como colaborador';
      log(errorMessage, error: e, stackTrace: s);
      return Failure(RepositoryException(errorMessage));
    }
  }

  @override
  Future<Either<RepositoryException, Nil>> registerEmployee(
      ({
        int barbershopId,
        String email,
        String name,
        String password,
        List<String> workDays,
        List<int> workHours,
      }) userModel) async {
    try {
      await restClient.auth.post('/users', data: {
        'name': userModel.name,
        'email': userModel.email,
        'password': userModel.password,
        'barbershop_id': userModel.barbershopId,
        'profile': 'EMPLOYEE',
        'work_days': userModel.workDays,
        'work_hours': userModel.workHours,
      });

      return Success(nil);
    } on DioException catch (e, s) {
      const errorMessage =
          'Erro ao registrar usuário administrador como colaborador';
      log(errorMessage, error: e, stackTrace: s);
      return Failure(RepositoryException(errorMessage));
    }
  }
}
