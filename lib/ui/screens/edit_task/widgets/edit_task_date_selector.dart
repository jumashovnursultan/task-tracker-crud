import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:adhdo_it_mob/helpers/date_helpers.dart';

class EditTaskDateSelector extends StatelessWidget {
  const EditTaskDateSelector({super.key, required this.selectedDate});

  final ValueNotifier<DateTime?> selectedDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(245, 245, 245, 1),
        borderRadius: BorderRadius.circular(100),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SvgPicture.asset('assets/svg/calendar.svg', color: Colors.black),
              const Gap(8),
              Text(
                formatDate(selectedDate.value!),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          Bounceable(
            onTap: () {
              selectedDate.value = null;
            },
            child: Container(
              height: 24,
              width: 24,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: SvgPicture.asset('assets/svg/cancel.svg'),
            ),
          ),
        ],
      ),
    );
  }
}
