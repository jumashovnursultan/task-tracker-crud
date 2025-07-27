import 'package:adhdo_it_mob/l10n/app_localizations.dart';

import 'package:adhdo_it_mob/ui/dialogs/calendar_bottom_sheet.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

enum TaskFilter {
  all,
  byPriority,
  byDate,
  byTime;

  bool get isAll => this == TaskFilter.all;
  bool get isByPriority => this == TaskFilter.byPriority;
  bool get isByDate => this == TaskFilter.byDate;
  bool get isByTime => this == TaskFilter.byTime;
}

extension TaskFilterExtension on TaskFilter {
  String get title {
    switch (this) {
      case TaskFilter.all:
        return 'All task';
      case TaskFilter.byPriority:
        return 'By priority';
      case TaskFilter.byDate:
        return 'By date';
      case TaskFilter.byTime:
        return 'By time';
    }
  }
}

class FilterDialog extends StatelessWidget {
  const FilterDialog({super.key, required this.taskFilter});

  final TaskFilter taskFilter;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: AnimatedContainer(
        alignment: Alignment.center,
        duration: Duration(seconds: 200),

        height: 237,
        width: 215,
        margin: EdgeInsets.only(top: 31, right: 24),
        padding: EdgeInsets.only(top: 10, bottom: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Material(
          borderRadius: BorderRadius.circular(20),
          color: Colors.transparent,
          child: Column(
            children: [
              Bounceable(
                hitTestBehavior: HitTestBehavior.opaque,
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        taskFilter.title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SvgPicture.asset('assets/svg/arrow_dropdown.svg'),
                    ],
                  ),
                ),
              ),
              Gap(10),
              Container(
                height: 1,
                width: double.infinity,
                color: Color(0xFFEEEEEE),
              ),
              Gap(8),
              Bounceable(
                onTap: () {
                  Navigator.pop(context, TaskFilter.all);
                },
                child: Container(
                  height: 44,
                  margin: const EdgeInsets.only(left: 16, right: 16),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color:
                        taskFilter.isAll
                            ? Color(0xFFF5F5F5)
                            : Colors.transparent,
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/svg/all_tasks_icon.svg'),
                      Gap(8),
                      Text(
                        Strings.of(context).allTask,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Bounceable(
                onTap: () {
                  Navigator.pop(context, TaskFilter.byPriority);
                },
                child: Container(
                  height: 44,
                  margin: const EdgeInsets.only(left: 16, right: 16),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color:
                        taskFilter.isByPriority
                            ? Color(0xFFF5F5F5)
                            : Colors.transparent,
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/svg/star_filled.svg',
                        color: Colors.black,
                      ),
                      Gap(8),
                      Text(
                        'By priority',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Bounceable(
                onTap: () async {
                  final date = await showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,

                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(30),
                      ),
                    ),
                    builder: (_) => const CalendarBottomSheet(),
                  );
                  if (date is DateTime) {
                    Navigator.pop(context, MapEntry(TaskFilter.byDate, date));
                  }
                },
                child: Container(
                  height: 44,
                  margin: const EdgeInsets.only(left: 16, right: 16),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color:
                        taskFilter.isByDate
                            ? Color(0xFFF5F5F5)
                            : Colors.transparent,
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/svg/calendar.svg'),
                      Gap(8),
                      Text(
                        'By date',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Bounceable(
                onTap: () async {
                  Navigator.pop(context, MapEntry(TaskFilter.byTime, true));
                },
                child: Container(
                  height: 44,
                  margin: const EdgeInsets.only(left: 16, right: 16),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color:
                        taskFilter.isByTime
                            ? Color(0xFFF5F5F5)
                            : Colors.transparent,
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/svg/watch.svg'),
                      Gap(8),
                      Text(
                        'By time',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
