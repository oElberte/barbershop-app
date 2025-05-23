import 'dart:developer';

import 'package:barbershop/src/core/ui/constants.dart';
import 'package:barbershop/src/core/ui/widgets/barbershop_loader.dart';
import 'package:barbershop/src/features/employee/schedule/appointment_ds.dart';
import 'package:barbershop/src/features/employee/schedule/employee_schedule_vm.dart';
import 'package:barbershop/src/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class EmployeeSchedulePage extends ConsumerStatefulWidget {
  const EmployeeSchedulePage({super.key});

  @override
  ConsumerState<EmployeeSchedulePage> createState() =>
      _EmployeeSchedulePageState();
}

class _EmployeeSchedulePageState extends ConsumerState<EmployeeSchedulePage> {
  late DateTime dateSelected;
  var ignoreFirstLoad = true;

  @override
  void initState() {
    final DateTime(:year, :month, :day) = DateTime.now();
    dateSelected = DateTime(year, month, day, 0, 0, 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final UserModel(id: userId, :name) =
        ModalRoute.of(context)!.settings.arguments as UserModel;

    final scheduleAsync =
        ref.watch(employeeScheduleVmProvider(userId, dateSelected));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Agenda'),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 24,
          ),
          Text(
            name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 44,
          ),
          scheduleAsync.when(
            loading: () => const Center(
              child: BarbershopLoader(),
            ),
            error: (error, stackTrace) {
              const errorMessage = 'Erro ao carregar agendamentos';
              log(errorMessage, error: error, stackTrace: stackTrace);
              return const Center(
                child: Text(errorMessage),
              );
            },
            data: (schedules) {
              return Expanded(
                child: SfCalendar(
                  view: CalendarView.day,
                  allowViewNavigation: true,
                  showNavigationArrow: true,
                  showDatePickerButton: true,
                  showTodayButton: true,
                  todayHighlightColor: ColorsConstants.brown,
                  dataSource: AppointmentDs(schedules),
                  onViewChanged: (viewChangedDetails) {
                    if (ignoreFirstLoad) {
                      ignoreFirstLoad = false;
                      return;
                    }

                    ref
                        .read(employeeScheduleVmProvider(userId, dateSelected)
                            .notifier)
                        .changeDate(
                          userId,
                          viewChangedDetails.visibleDates.first,
                        );
                  },
                  onTap: (tapDetails) {
                    if (tapDetails.appointments != null &&
                        tapDetails.appointments!.isNotEmpty) {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          final dateFormat = DateFormat('dd/MM/yyyy - HH:mm');

                          return SizedBox(
                            height: 200,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                      'Cliente: ${tapDetails.appointments!.first.subject}'),
                                  Text(
                                      'Horário: ${dateFormat.format(tapDetails.date ?? DateTime.now())}'),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
