import 'package:adhdo_it_mob/ui/dialogs/duration_time_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:adhdo_it_mob/helpers/date_helpers.dart';

class EditTaskDurationSelector extends StatelessWidget {
  const EditTaskDurationSelector({super.key, required this.selectedDuration});

  final ValueNotifier<Duration?> selectedDuration;

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: () async {
        final duration = await showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
          builder: (_) => DurationTimeBottomSheet(selectedDuration.value),
        );

        if (duration is Duration) {
          selectedDuration.value = duration;
        }
      },
      child: Container(
        height: 44,
        decoration: BoxDecoration(
          color:
              selectedDuration.value != null
                  ? const Color.fromRGBO(245, 245, 245, 1)
                  : null,
          borderRadius: BorderRadius.circular(100),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset('assets/svg/watch.svg', color: Colors.black),
                const Gap(8),
                Text(
                  selectedDuration.value != null
                      ? formatDuration(selectedDuration.value!)
                      : 'Duration',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            if (selectedDuration.value != null)
              Bounceable(
                onTap: () {
                  selectedDuration.value = null;
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
