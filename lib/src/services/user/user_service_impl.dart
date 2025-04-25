import 'package:barbershop/src/core/constants/local_storage_keys.dart';
import 'package:barbershop/src/core/exceptions/auth_exception.dart';
import 'package:barbershop/src/core/exceptions/service_exception.dart';
import 'package:barbershop/src/core/fp/either.dart';
import 'package:barbershop/src/core/fp/nil.dart';
import 'package:barbershop/src/repositories/user/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './user_service.dart';

class UserServiceImpl implements UserService {
  final UserRepository userRepository;

  UserServiceImpl({required this.userRepository});

  @override
  Future<Either<ServiceException, Nil>> login(
      String email, String password) async {
    final loginResult = await userRepository.login(email, password);

    switch (loginResult) {
      case Failure(:final exception):
        return switch (exception) {
          AuthError() => Failure(ServiceException('Erro ao realizar login')),
          AuthUnauthorizedException() =>
            Failure(ServiceException('Login ou senha inválidos')),
        };
      case Success(value: final accessToken):
        final sp = await SharedPreferences.getInstance();
        sp.setString(LocalStorageKeys.accessToken, accessToken);
        return Success(nil);
    }
  }

  @override
  Future<Either<ServiceException, Nil>> registerAdmin(
    ({
      String email,
      String name,
      String password,
    }) userData,
  ) async {
    final registerResult = await userRepository.registerAdmin(userData);

    switch (registerResult) {
      case Failure(:final exception):
        return Failure(ServiceException(exception.message));
      case Success():
        return login(userData.email, userData.password);
    }
  }
}
