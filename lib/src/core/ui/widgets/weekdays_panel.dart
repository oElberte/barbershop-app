import 'package:dw_barbershop/src/core/ui/widgets/button_day.dart';
import 'package:flutter/material.dart';

class WeekdaysPanel extends StatelessWidget {
  const WeekdaysPanel({
    super.key,
    required this.onDayTapped,
  });

  final ValueChanged<String> onDayTapped;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Selecione os dias da semana',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ButtonDay(label: 'Seg', onDayTapped: onDayTapped),
                ButtonDay(label: 'Ter', onDayTapped: onDayTapped),
                ButtonDay(label: 'Qua', onDayTapped: onDayTapped),
                ButtonDay(label: 'Qui', onDayTapped: onDayTapped),
                ButtonDay(label: 'Sex', onDayTapped: onDayTapped),
                ButtonDay(label: 'Sáb', onDayTapped: onDayTapped),
                ButtonDay(label: 'Dom', onDayTapped: onDayTapped),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
