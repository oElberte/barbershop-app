import 'dart:developer';

import 'package:barbershop/src/core/providers/application_providers.dart';
import 'package:barbershop/src/core/ui/helpers/messages.dart';
import 'package:barbershop/src/core/ui/widgets/avatar_widget.dart';
import 'package:barbershop/src/core/ui/widgets/barbershop_loader.dart';
import 'package:barbershop/src/core/ui/widgets/hours_panel.dart';
import 'package:barbershop/src/core/ui/widgets/weekdays_panel.dart';
import 'package:barbershop/src/features/employee/register/employee_register_state.dart';
import 'package:barbershop/src/features/employee/register/employee_register_vm.dart';
import 'package:barbershop/src/models/barbershop_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:validatorless/validatorless.dart';

class EmployeeRegisterPage extends ConsumerStatefulWidget {
  const EmployeeRegisterPage({super.key});

  @override
  ConsumerState<EmployeeRegisterPage> createState() =>
      _EmployeeRegisterPageState();
}

class _EmployeeRegisterPageState extends ConsumerState<EmployeeRegisterPage> {
  var registerAdm = false;
  final formKey = GlobalKey<FormState>();
  final nameEC = TextEditingController();
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();

  @override
  void dispose() {
    nameEC.dispose();
    emailEC.dispose();
    passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final employeeRegisterVm = ref.watch(employeeRegisterVmProvider.notifier);
    final barbershopAsyncValue = ref.watch(getMyBarbershopProvider);

    ref.listen(employeeRegisterVmProvider.select((state) => state.status),
        (_, status) {
      switch (status) {
        case EmployeeRegisterStateStatus.initial:
          break;
        case EmployeeRegisterStateStatus.success:
          Messages.showSuccess('Colaborador cadastrado com sucesso', context);
          Navigator.of(context).pop();
          break;
        case EmployeeRegisterStateStatus.error:
          Messages.showError('Erro ao cadastrar colaborador', context);
          break;
        default:
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar colaborador'),
      ),
      body: barbershopAsyncValue.when(
        error: (error, stackTrace) {
          const errorMessage = 'Erro ao carregar a página';
          log(errorMessage, error: error, stackTrace: stackTrace);
          return const Center(
            child: Text(errorMessage),
          );
        },
        loading: () {
          return const Center(
            child: BarbershopLoader(),
          );
        },
        data: (barbershopModel) {
          final BarbershopModel(:openingDays, :openingHours) = barbershopModel;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Center(
                child: Column(
                  children: [
                    const AvatarWidget(),
                    const SizedBox(
                      height: 32,
                    ),
                    Row(
                      children: [
                        Checkbox.adaptive(
                          value: registerAdm,
                          onChanged: (value) => setState(() {
                            registerAdm = !registerAdm;
                            employeeRegisterVm.setRegisterAdm(registerAdm);
                          }),
                        ),
                        const Expanded(
                          child: Text(
                            'Sou administrador e quero me cadastrar como colaborador',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                    Offstage(
                      offstage: registerAdm,
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 24,
                            ),
                            TextFormField(
                              controller: nameEC,
                              validator: registerAdm
                                  ? null
                                  : Validatorless.required('Nome obrigatório'),
                              decoration: const InputDecoration(
                                label: Text('Nome'),
                              ),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            TextFormField(
                              controller: emailEC,
                              validator: registerAdm
                                  ? null
                                  : Validatorless.multiple([
                                      Validatorless.required(
                                          'Email obrigatório'),
                                      Validatorless.email('Email inválido'),
                                    ]),
                              decoration: const InputDecoration(
                                label: Text('Email'),
                              ),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            TextFormField(
                              controller: passwordEC,
                              obscureText: true,
                              validator: registerAdm
                                  ? null
                                  : Validatorless.multiple([
                                      Validatorless.required(
                                          'Senha obrigatória'),
                                      Validatorless.min(6,
                                          'Senha deve ter no mínimo 6 caracteres'),
                                    ]),
                              decoration: const InputDecoration(
                                label: Text('Senha'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    WeekdaysPanel(
                      onDayTapped: employeeRegisterVm.addOrRemoveWorkDays,
                      enabledDays: openingDays,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    HoursPanel(
                      startTime: 6,
                      endTime: 23,
                      onHourTapped: employeeRegisterVm.addOrRemoveWorkHours,
                      enabledHours: openingHours,
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
                          case false || null:
                            Messages.showError(
                                'Existem campos inválidos', context);
                          case true:
                            final EmployeeRegisterState(
                              workDays: List(isNotEmpty: hasWorkDays),
                              workHours: List(isNotEmpty: hasWorkHours),
                            ) = ref.watch(employeeRegisterVmProvider);

                            if (!hasWorkDays || !hasWorkHours) {
                              Messages.showError(
                                'Por favor selecione os dias da semana e horários de atendimento',
                                context,
                              );
                              return;
                            }

                            final name = nameEC.text;
                            final email = emailEC.text;
                            final password = passwordEC.text;

                            employeeRegisterVm.register(
                                name: name, email: email, password: password);
                        }
                      },
                      child: const Text('CADASTRAR COLABORADOR'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
