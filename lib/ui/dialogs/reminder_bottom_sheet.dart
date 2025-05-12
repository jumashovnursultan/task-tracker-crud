import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

class ReminderBottomSheet extends HookWidget {
  const ReminderBottomSheet(
    this.initialTime, {
    super.key,
    this.backgroundColor = Colors.white,
  });

  final DateTime? initialTime;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();

    final selectedTime = useState(
      initialTime ??
          DateTime(
            now.year,
            now.month,
            now.day,
            now.hour,
            (now.minute / 15).round() * 15 % 60,
          ),
    );
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 1.86,
              width: 24,
              decoration: BoxDecoration(
                color: Color(0xFF92918A),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            Gap(5),
            SizedBox(
              width: double.infinity,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Text('Remind', style: TextStyle(fontSize: 20)),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Bounceable(
                        onTap: () {
                          Navigator.pop(context, selectedTime.value);
                        },
                        child: Text(
                          'Ready',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 250,
              child: CupertinoDatePicker(
                use24hFormat: true,
                mode: CupertinoDatePickerMode.time,
                minuteInterval: 1,
                initialDateTime: selectedTime.value,
                onDateTimeChanged: (value) {
                  selectedTime.value = value;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
