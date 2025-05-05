import 'package:adhdo_it_mob/l10n/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

enum TaskFilter { all, byPriority, byDate, byTime }

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
      child: Material(
        borderRadius: BorderRadius.circular(20),
        child: AnimatedContainer(
          alignment: Alignment.center,
          duration: Duration(seconds: 200),

          height: 237,
          width: 215,
          padding: EdgeInsets.only(top: 10, bottom: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Column(
            children: [
              Padding(
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
              Gap(10),
              Container(
                height: 1,
                width: double.infinity,
                color: Color(0xFFEEEEEE),
              ),
              Gap(8),
              Container(
                height: 44,
                margin: const EdgeInsets.only(left: 16, right: 16),
                padding: EdgeInsets.symmetric(horizontal: 16),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Color(0xFFF5F5F5),
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
              Container(
                height: 44,
                margin: const EdgeInsets.only(left: 16, right: 16),
                padding: EdgeInsets.symmetric(horizontal: 16),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Color(0xFFF5F5F5),
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
              Container(
                height: 44,
                margin: const EdgeInsets.only(left: 16, right: 16),
                padding: EdgeInsets.symmetric(horizontal: 16),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Color(0xFFF5F5F5),
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
              Container(
                height: 44,
                margin: const EdgeInsets.only(left: 16, right: 16),
                padding: EdgeInsets.symmetric(horizontal: 16),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Color(0xFFF5F5F5),
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
            ],
          ),
        ),
      ),
    );
  }
}
