import 'package:to_do/ui/dialogs/date_picker_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:to_do/helpers/date_helpers.dart';

class EditTaskDateSelector extends StatelessWidget {
  const EditTaskDateSelector({super.key, required this.selectedDate});

  final ValueNotifier<DateTime?> selectedDate;

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: () async {
        final date = await showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
          builder: (_) => DateBottomSheet(initialDate: selectedDate.value),
        );
        if (date is DateTime) {
          selectedDate.value = date;
        }
      },
      child: Container(
        height: 44,
        decoration: BoxDecoration(
          color:
              selectedDate.value != null
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
                SvgPicture.asset(
                  'assets/svg/calendar.svg',
                  color: Colors.black,
                ),
                const Gap(8),
                Text(
                  selectedDate.value != null
                      ? formatDate(selectedDate.value!)
                      : 'Date',
                  style: TextStyle(
                    fontSize: selectedDate.value != null ? 16 : null,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            if (selectedDate.value != null)
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
              )
            else
              SvgPicture.asset('assets/svg/arrow_forward.svg'),
          ],
        ),
      ),
    );
  }
}
