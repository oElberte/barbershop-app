import 'package:dw_barbershop/src/core/exceptions/service_exception.dart';
import 'package:dw_barbershop/src/core/fp/either.dart';
import 'package:dw_barbershop/src/core/fp/nil.dart';

abstract interface class UserService {
  Future<Either<ServiceException, Nil>> login(String email, String password);
  Future<Either<ServiceException, Nil>> registerAdmin(
    ({
      String name,
      String email,
      String password,
    }) userData,
  );
}
