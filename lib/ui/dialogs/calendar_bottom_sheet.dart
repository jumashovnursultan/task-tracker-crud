import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarBottomSheet extends HookWidget {
  const CalendarBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedDay = useState(DateTime.now());
    final focusedDay = useState(DateTime.now());

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
            TableCalendar(
              calendarBuilders: CalendarBuilders(
                dowBuilder: (context, day) {
                  final text =
                      DateFormat.E().format(day).toUpperCase(); // 👈 👈 👈
                  return Center(
                    child: Text(
                      text,
                      style: TextStyle(
                        color: Color(0xFF92918A),
                        fontWeight: FontWeight.bold,

                        fontSize: 10,
                      ),
                    ),
                  );
                },
                headerTitleBuilder: (context, date) {
                  final month = date.month;
                  final year = date.year;
                  final monthName =
                      '${_monthName(month)} $year'; // Например, April 2025

                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            monthName,
                            style: const TextStyle(
                              fontSize: 20,
                              color: Color(0xFF000000),
                            ),
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  final previousMonth = DateTime(
                                    focusedDay.value.year,
                                    focusedDay.value.month - 1,
                                  );

                                  final firstAvailable = DateTime(
                                    DateTime.now().year,
                                    DateTime.now().month,
                                    1,
                                  );
                                  if (!previousMonth.isBefore(firstAvailable)) {
                                    focusedDay.value = previousMonth;
                                  }
                                },
                                child: SvgPicture.asset(
                                  'assets/svg/arrow_back1.svg',
                                  height: 16,
                                ),
                              ),
                              const Gap(24),
                              GestureDetector(
                                onTap:
                                    () =>
                                        focusedDay.value = DateTime(
                                          focusedDay.value.year,
                                          focusedDay.value.month + 1,
                                        ),
                                child: SvgPicture.asset(
                                  'assets/svg/arrow_forward1.svg',
                                  height: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Gap(13),
                      Container(
                        height: 0.8,
                        width: double.infinity,
                        color: Color(0xFFE4E5E7),
                      ),
                      Gap(16),
                    ],
                  );
                },
              ),
              onDisabledDayTapped: (day) => print('data'),
              firstDay: DateTime(DateTime.now().year, DateTime.now().month, 1),
              lastDay: DateTime.utc(2030, 12, 31),

              focusedDay: focusedDay.value,
              selectedDayPredicate: (day) => isSameDay(day, selectedDay.value),
              onDaySelected: (selected, focused) {
                selectedDay.value = selected;
                focusedDay.value = focused;

                Navigator.pop(context, selected);
              },

              startingDayOfWeek: StartingDayOfWeek.monday,
              calendarStyle: CalendarStyle(
                cellAlignment: Alignment.center,
                selectedDecoration: BoxDecoration(
                  color: const Color(0xFFFFEE00),
                  shape: BoxShape.circle,
                ),

                selectedTextStyle: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                defaultTextStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                weekendTextStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),

              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                leftChevronVisible: false,
                rightChevronVisible: false,
                headerPadding: EdgeInsets.only(left: 10, right: 10),

                titleTextStyle: const TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _monthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return months[month - 1];
  }
}
