import 'package:dw_barbershop/src/core/ui/widgets/hour_button.dart';
import 'package:flutter/material.dart';

class HoursPanel extends StatelessWidget {
  const HoursPanel({
    super.key,
    required this.startTime,
    required this.endTime,
    required this.onHourTapped,
    this.enabledHours,
  });

  final int startTime;
  final int endTime;
  final ValueChanged<int> onHourTapped;
  final List<int>? enabledHours;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Selecione os horários de atendimento',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Wrap(
          spacing: 8,
          runSpacing: 16,
          children: [
            for (int i = startTime; i <= endTime; i++)
              HourButton(
                enabledHours: enabledHours,
                label: '${i.toString().padLeft(2, '0')}:00',
                value: i,
                onHourTapped: onHourTapped,
              ),
          ],
        ),
      ],
    );
  }
}
