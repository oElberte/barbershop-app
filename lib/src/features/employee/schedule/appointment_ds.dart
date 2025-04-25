import 'package:barbershop/src/core/ui/constants.dart';
import 'package:barbershop/src/models/schedule_model.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class AppointmentDs extends CalendarDataSource {
  AppointmentDs(this.schedules);

  final List<ScheduleModel> schedules;

  @override
  List<dynamic>? get appointments {
    return schedules.map<Appointment>(
      (e) {
        final ScheduleModel(
          date: DateTime(:year, :month, :day),
          :hour,
          :clientName
        ) = e;

        final startTime = DateTime(year, month, day, hour, 0, 0);
        final endTime = DateTime(year, month, day, hour + 1, 0, 0);

        return Appointment(
          startTime: startTime,
          endTime: endTime,
          subject: clientName,
          color: ColorsConstants.brown,
        );
      },
    ).toList();
  }
}
