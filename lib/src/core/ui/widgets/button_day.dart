import 'package:barbershop/src/core/ui/constants.dart';
import 'package:flutter/material.dart';

class ButtonDay extends StatefulWidget {
  const ButtonDay({
    super.key,
    required this.label,
    required this.onDayTapped,
    this.enabledDays,
  });

  final String label;
  final ValueChanged<String> onDayTapped;
  final List<String>? enabledDays;

  @override
  State<ButtonDay> createState() => _ButtonDayState();
}

class _ButtonDayState extends State<ButtonDay> {
  var isSelected = false;

  @override
  Widget build(BuildContext context) {
    final textColor = isSelected ? Colors.white : ColorsConstants.grey;
    var buttonColor = isSelected ? ColorsConstants.brown : Colors.white;
    final buttonBorderColor =
        isSelected ? ColorsConstants.brown : ColorsConstants.grey;

    final ButtonDay(:enabledDays, :label, :onDayTapped) = widget;

    final disabledDay = enabledDays != null && !enabledDays.contains(label);

    if (disabledDay) {
      buttonColor = Colors.grey[400]!;
    }

    return Padding(
      padding: const EdgeInsets.all(5),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: disabledDay
            ? null
            : () => setState(() {
                  isSelected = !isSelected;
                  onDayTapped(label);
                }),
        child: Container(
          width: 40,
          height: 56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: buttonColor,
            border: Border.all(color: buttonBorderColor),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: textColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
