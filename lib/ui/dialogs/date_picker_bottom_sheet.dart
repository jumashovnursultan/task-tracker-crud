import 'dart:ui';

import 'package:to_do/ui/dialogs/calendar_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class DateBottomSheet extends HookWidget {
  const DateBottomSheet({super.key, this.initialDate});

  final DateTime? initialDate;

  @override
  Widget build(BuildContext context) {
    final selectedDate = useState<DateTime?>(initialDate);

    Widget _buildOption({
      required String title,
      required String trailing,
      required String iconPath,
      required bool isSelected,
      required VoidCallback onTap,
    }) {
      return Container(
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFF5F5F5) : Colors.transparent,
          borderRadius: BorderRadius.circular(100),
        ),
        child: ListTile(
          leading: SvgPicture.asset(iconPath),
          title: Text(
            title,
            style: TextStyle(
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w400,
            ),
          ),
          trailing: Text(trailing),
          onTap: onTap,
        ),
      );
    }

    bool isSameDate(DateTime a, DateTime b) {
      return a.year == b.year && a.month == b.month && a.day == b.day;
    }

    final now = DateTime.now();
    final tomorrow = now.add(const Duration(days: 1));

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          color: Colors.white,
        ),
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
            const Text("Date", style: TextStyle(fontSize: 20)),
            const Gap(16),

            // Today
            _buildOption(
              title: "Today",
              trailing: DateFormat('E').format(now),
              iconPath: 'assets/svg/calendar_today.svg',
              isSelected:
                  selectedDate.value != null &&
                  isSameDate(selectedDate.value!, now),
              onTap: () {
                selectedDate.value = now;
                Navigator.pop(context, selectedDate.value);
              },
            ),
            const Gap(5),

            // Tomorrow
            _buildOption(
              title: "Tomorrow",
              trailing: DateFormat('E').format(tomorrow),
              iconPath: 'assets/svg/calendar_tomorrow.svg',
              isSelected:
                  selectedDate.value != null &&
                  isSameDate(selectedDate.value!, tomorrow),
              onTap: () {
                selectedDate.value = tomorrow;
                Navigator.pop(context, selectedDate.value);
              },
            ),
            const Gap(5),

            // Select date
            Container(
              decoration: BoxDecoration(
                color:
                    selectedDate.value != null &&
                            !isSameDate(selectedDate.value!, now) &&
                            !isSameDate(selectedDate.value!, tomorrow)
                        ? const Color(0xFFF5F5F5)
                        : Colors.transparent,
                borderRadius: BorderRadius.circular(100),
              ),
              child: ListTile(
                leading: SvgPicture.asset('assets/svg/calendar.svg'),
                title: Text(
                  selectedDate.value != null &&
                          !isSameDate(selectedDate.value!, now) &&
                          !isSameDate(selectedDate.value!, tomorrow)
                      ? DateFormat('d MMMM yyyy').format(selectedDate.value!)
                      : "Select date",
                  style: TextStyle(
                    fontWeight:
                        selectedDate.value != null &&
                                !isSameDate(selectedDate.value!, now) &&
                                !isSameDate(selectedDate.value!, tomorrow)
                            ? FontWeight.bold
                            : FontWeight.w400,
                  ),
                ),
                trailing: SvgPicture.asset('assets/svg/arrow_forward.svg'),
                onTap: () async {
                  final date = await showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    barrierColor: Colors.transparent,

                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(30),
                      ),
                    ),
                    builder: (_) => const CalendarBottomSheet(),
                  );

                  if (date is DateTime) {
                    selectedDate.value = date;
                  }
                  Navigator.pop(context, date);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
