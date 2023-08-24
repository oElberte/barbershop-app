import 'package:dw_barbershop/src/models/user_model.dart';

enum HomeAdmStateStatus {
  loaded,
  error,
}

class HomeAdmState {
  final HomeAdmStateStatus status;
  final List<UserModel> employees;

  const HomeAdmState({
    required this.status,
    required this.employees,
  });

  HomeAdmState copyWith({
    HomeAdmStateStatus? status,
    List<UserModel>? employees,
  }) {
    return HomeAdmState(
      status: status ?? this.status,
      employees: employees ?? this.employees,
    );
  }
}
