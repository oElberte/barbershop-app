import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dw_barbershop/src/core/exceptions/auth_exception.dart';
import 'package:dw_barbershop/src/core/fp/either.dart';
import 'package:dw_barbershop/src/core/rest_client/rest_client.dart';

import './user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final RestClient restClient;

  UserRepositoryImpl({required this.restClient});

  @override
  Future<Either<AuthException, String>> login(String email, String password) async {
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
}
