import 'package:adhdo_it_mob/ui/dialogs/reminder_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class EditTaskReminderSelector extends StatelessWidget {
  const EditTaskReminderSelector({
    super.key,
    required this.selectedReminderTime,
  });

  final ValueNotifier<DateTime?> selectedReminderTime;

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: () async {
        final time = await showModalBottomSheet(
          context: context,
          isScrollControlled: true,

          backgroundColor: Colors.transparent,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
          builder: (_) => ReminderBottomSheet(null),
        );

        if (time is DateTime) {
          selectedReminderTime.value = time;
        }
      },
      child: Container(
        height: 44,
        decoration: BoxDecoration(
          color:
              selectedReminderTime.value != null
                  ? const Color.fromRGBO(245, 245, 245, 1)
                  : null,
          borderRadius: BorderRadius.circular(100),
        ),
        padding: const EdgeInsets.only(right: 16, left: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              alignment: Alignment.centerLeft,
              children: [
                SvgPicture.asset('assets/svg/bell.svg', color: Colors.black),
                Padding(
                  padding: const EdgeInsets.only(left: 42),
                  child: Text(
                    selectedReminderTime.value != null
                        ? 'At ${DateFormat('HH:mm').format(selectedReminderTime.value!)}'
                        : 'Remind',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            if (selectedReminderTime.value != null)
              Bounceable(
                onTap: () {
                  selectedReminderTime.value = null;
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
              )
            else
              SvgPicture.asset('assets/svg/arrow_forward.svg'),
          ],
        ),
      ),
    );
  }
}
