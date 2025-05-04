import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

class DurationTimeBottomSheet extends HookWidget {
  const DurationTimeBottomSheet(this.initialDuration, {super.key});

  final Duration? initialDuration;

  @override
  Widget build(BuildContext context) {
    final selectedDuration = useState(initialDuration ?? Duration());
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
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
                  const Text('Time for task', style: TextStyle(fontSize: 20)),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Bounceable(
                        onTap: () {
                          Navigator.pop(context, selectedDuration.value);
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
            CupertinoTimerPicker(
              initialTimerDuration: selectedDuration.value,
              mode: CupertinoTimerPickerMode.hms,

              onTimerDurationChanged: (value) {
                selectedDuration.value = value;
              },
            ),
          ],
        ),
      ),
    );
  }
}
