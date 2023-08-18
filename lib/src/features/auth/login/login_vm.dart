import 'package:asyncstate/asyncstate.dart';
import 'package:dw_barbershop/src/core/exceptions/service_exception.dart';
import 'package:dw_barbershop/src/core/fp/either.dart';
import 'package:dw_barbershop/src/core/fp/nil.dart';
import 'package:dw_barbershop/src/core/providers/application_providers.dart';
import 'package:dw_barbershop/src/features/auth/login/login_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_vm.g.dart';

@riverpod
class LoginVm extends _$LoginVm {
  @override
  LoginState build() => LoginState.initial();

  Future<void> login(String email, String password) async {
    final loaderHandler = AsyncLoaderHandler()..start();

    final loginService = ref.watch(userServiceProvider);

    final loginResult = await loginService.login(email, password);

    switch (loginResult) {
      case Failure<ServiceException, Nil>(exception: ServiceException(:final message)):
        state = state.copyWith(
          status: LoginStateStatus.failure,
          errorMessage: () => message,
        );
      case Success<ServiceException, Nil>():
      
    }

    loaderHandler.close();
  }
}
