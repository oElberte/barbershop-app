sealed class UserModel {
  final int id;
  final String name;
  final String email;
  final String? avatar;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.avatar,
  });

  factory UserModel.fromMap(Map<String, dynamic> json) {
    return switch (json['profile']) {
      'ADM' => UserModelAdm.fromMap(json),
      'EMPLOYEE' => UserModelEmployee.fromMap(json),
      _ => throw ArgumentError('User profile not found'),
    };
  }
}

class UserModelAdm extends UserModel {
  final List<String>? workDays;
  final List<int>? workHours;

  UserModelAdm({
    required super.id,
    required super.name,
    required super.email,
    super.avatar,
    this.workDays,
    this.workHours,
  });

  factory UserModelAdm.fromMap(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': final int id,
        'name': final String name,
        'email': final String email,
      } =>
        UserModelAdm(
          id: id,
          name: name,
          email: email,
          avatar: json['avatar'],
          workDays: json['work_days']?.cast<String>(),
          workHours: json['work_hours']?.cast<int>(),
        ),
        _ => throw ArgumentError('Invalid Json'),
    };
  }
}

class UserModelEmployee extends UserModel {
  final int barbershopId;
  final List<String> workDays;
  final List<int> workHours;

  UserModelEmployee({
    required super.id,
    required super.name,
    required super.email,
    super.avatar,
    required this.barbershopId,
    required this.workDays,
    required this.workHours,
  });

  factory UserModelEmployee.fromMap(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': final int id,
        'barbershop_id': final int barbershopId,
        'name': final String name,
        'email': final String email,
        'work_days': final List<String> workDays,
        'work_hours': final List<int> workHours,
      } =>
        UserModelEmployee(
          id: id,
          barbershopId: barbershopId,
          name: name,
          email: email,
          avatar: json['avatar'],
          workDays: workDays,
          workHours: workHours,
        ),
        _ => throw ArgumentError('Invalid Json'),
    };
  }
}
