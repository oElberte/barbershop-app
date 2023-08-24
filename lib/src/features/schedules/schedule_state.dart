import 'package:flutter/material.dart';

enum ScheduleStateStatus {
  initial,
  success,
  error,
}

class ScheduleState {
  final ScheduleStateStatus status;
  final int? scheduleHour;
  final DateTime? scheduleDate;

  const ScheduleState({
    required this.status,
    this.scheduleHour,
    this.scheduleDate,
  });

  const ScheduleState.initial() : this(status: ScheduleStateStatus.initial);
  ScheduleState copyWith({
    ScheduleStateStatus? status,
    ValueGetter<int?>? scheduleHour,
    ValueGetter<DateTime?>? scheduleDate,
  }) {
    return ScheduleState(
      status: status ?? this.status,
      scheduleHour: scheduleHour != null ? scheduleHour() : this.scheduleHour,
      scheduleDate: scheduleDate != null ? scheduleDate() : this.scheduleDate,
    );
  }
}
