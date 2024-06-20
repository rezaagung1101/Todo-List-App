import 'package:flutter/material.dart';

class ButtonDatePicker extends StatelessWidget {
  const ButtonDatePicker({super.key, required this.onTap, this.selectedDueDate});
  final VoidCallback onTap;
  final DateTime? selectedDueDate;

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      splashColor: Colors.blue[100],
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: SizedBox(
        height: 50,
        child: Card.outlined(
          child: Row(
            children: <Widget>[
              const SizedBox(
                width: 16,
              ),
              const Icon(Icons.calendar_month_outlined),
              const SizedBox(
                width: 16,
              ),
              Text(
                selectedDueDate != null
                    ? 'Due Date: ${selectedDueDate!
                    .toLocal()
                    .toString()
                    .split(' ')[0]}'
                    : 'Due Date',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
