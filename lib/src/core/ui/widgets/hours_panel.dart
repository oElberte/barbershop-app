import 'package:barbershop/src/core/ui/widgets/hour_button.dart';
import 'package:flutter/material.dart';

class HoursPanel extends StatefulWidget {
  const HoursPanel({
    super.key,
    required this.startTime,
    required this.endTime,
    required this.onHourTapped,
    this.enabledHours,
  }) : singleSelection = false;

  const HoursPanel.singleSelection({
    super.key,
    required this.startTime,
    required this.endTime,
    required this.onHourTapped,
    this.enabledHours,
  }) : singleSelection = true;

  final int startTime;
  final int endTime;
  final ValueChanged<int> onHourTapped;
  final List<int>? enabledHours;
  final bool singleSelection;

  @override
  State<HoursPanel> createState() => _HoursPanelState();
}

class _HoursPanelState extends State<HoursPanel> {
  int? lastSelection;

  @override
  Widget build(BuildContext context) {
    final HoursPanel(
      :singleSelection,
      :startTime,
      :endTime,
      :enabledHours,
      :onHourTapped
    ) = widget;

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
                singleSelection: singleSelection,
                hourSelected: lastSelection,
                onHourTapped: (selectedHour) {
                  setState(() {
                    if (singleSelection) {
                      if (lastSelection == selectedHour) {
                        lastSelection = null;
                      } else {
                        lastSelection = selectedHour;
                      }
                    }

                    onHourTapped(selectedHour);
                  });
                },
              ),
          ],
        ),
      ],
    );
  }
}
