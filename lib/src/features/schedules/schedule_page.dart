import 'package:dw_barbershop/src/core/ui/barbershop_icons.dart';
import 'package:dw_barbershop/src/core/ui/constants.dart';
import 'package:dw_barbershop/src/core/ui/helpers/messages.dart';
import 'package:dw_barbershop/src/core/ui/widgets/avatar_widget.dart';
import 'package:dw_barbershop/src/core/ui/widgets/hours_panel.dart';
import 'package:dw_barbershop/src/features/schedules/widgets/schedule_calendar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:validatorless/validatorless.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  var dateFormat = DateFormat('dd/MM/yyyy');
  var showCalendar = false;
  final formKey = GlobalKey<FormState>();
  final clientEC = TextEditingController();
  final dateEC = TextEditingController();

  @override
  void dispose() {
    clientEC.dispose();
    dateEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agendar cliente'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Center(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  const AvatarWidget(hideUploadButton: true),
                  const SizedBox(
                    height: 24,
                  ),
                  const Text(
                    'Nome e sobrenome',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 37,
                  ),
                  TextFormField(
                    controller: clientEC,
                    validator: Validatorless.required('Cliente obrigatório'),
                    decoration: const InputDecoration(
                      label: Text('Cliente'),
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  TextFormField(
                    controller: dateEC,
                    validator: Validatorless.required('Data obrigatória'),
                    readOnly: true,
                    onTap: () => setState(() {
                      showCalendar = true;
                      FocusScope.of(context).unfocus();
                    }),
                    decoration: const InputDecoration(
                      label: Text('Selecione uma data'),
                      hintText: 'Selecione uma data',
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      suffixIcon: Icon(
                        BarbershopIcons.calendar,
                        color: ColorsConstants.brown,
                      ),
                    ),
                  ),
                  Offstage(
                    offstage: !showCalendar,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 24,
                        ),
                        ScheduleCalendar(
                          cancelPressed: () => setState(() {
                            showCalendar = false;
                          }),
                          okPressed: (value) => setState(() {
                            dateEC.text = dateFormat.format(value);
                            showCalendar = false;
                          }),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  HoursPanel.singleSelection(
                    startTime: 6,
                    endTime: 23,
                    enabledHours: const [6, 7, 8],
                    onHourTapped: (value) {},
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(56),
                    ),
                    onPressed: () {
                      switch (formKey.currentState?.validate()) {
                        case null || false:
                          Messages.showError('Dados incompletos', context);
                        case true:
                        //Chamada da VM
                      }
                    },
                    child: const Text('AGENDAR'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
