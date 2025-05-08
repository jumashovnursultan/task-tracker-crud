import 'dart:io';

import 'package:adhdo_it_mob/data/models/task_model.dart';
import 'package:adhdo_it_mob/helpers/date_helpers.dart';
import 'package:adhdo_it_mob/l10n/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class EditTaskScreen extends HookConsumerWidget {
  const EditTaskScreen(this.model, {super.key});

  final TaskModel model;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textEditController = useTextEditingController(text: model.title);
    final priority = useState(model.priority);
    final selectedDate = useState<DateTime?>(model.date);
    final selectedDuration = useState<Duration?>(
      Duration(seconds: model.durationInSeconds),
    );
    final selectedReminderTime = useState<DateTime?>(model.date);
    final selectedImage = useState<dynamic>(model.backgroundImage);

    Widget buildChip({required Widget child, required VoidCallback onCancel}) {
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
            child,
            Bounceable(
              onTap: onCancel,
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

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const Gap(32),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Row(
                  children: [
                    const Gap(5),
                    SvgPicture.asset('assets/svg/arrow_back.svg'),
                    Text(
                      Strings.of(context).myTask,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              const Gap(16),
              TextFormField(
                maxLines: 5,
                controller: textEditController,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
                decoration: InputDecoration(
                  hintText: 'Title',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.red, width: 1),
                  ),
                ),
              ),
              const Gap(16),
              // Priority
              Container(
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
                        SvgPicture.asset(
                          'assets/svg/star_filled.svg',
                          color: Colors.black,
                        ),
                        const Gap(8),
                        const Text(
                          'Priority',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    Flexible(
                      child: SizedBox(
                        height: 24,
                        width: 184,
                        child: ListView.separated(
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          separatorBuilder: (_, __) => const Gap(16),
                          itemBuilder:
                              (context, index) => GestureDetector(
                                onTap:
                                    () =>
                                        priority.value =
                                            priority.value == index + 1
                                                ? 0
                                                : index + 1,
                                child: SvgPicture.asset(
                                  index < priority.value
                                      ? 'assets/svg/star_filled.svg'
                                      : 'assets/svg/star_outline.svg',
                                  color:
                                      index < priority.value
                                          ? const Color(0xFFFF4C4C)
                                          : null,
                                ),
                              ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(8),
              // Date
              buildChip(
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/svg/calendar.svg',
                      color: Colors.black,
                    ),
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
                onCancel: () => selectedDate.value = null,
              ),
              const Gap(8),
              // Duration
              buildChip(
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/svg/watch.svg',
                      color: Colors.black,
                    ),
                    const Gap(8),
                    Text(
                      formatDuration(selectedDuration.value!),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                onCancel: () => selectedDuration.value = null,
              ),
              const Gap(8),
              // Reminder
              buildChip(
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/svg/bell.svg',
                      color: Colors.black,
                    ),
                    const Gap(8),
                    Text(
                      'At ${DateFormat('HH:mm').format(selectedReminderTime.value!)}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                onCancel: () => selectedReminderTime.value = null,
              ),
              const Gap(8),
              // Photo
              buildChip(
                child: Row(
                  children: [
                    if (selectedImage.value is File)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.file(
                          selectedImage.value,
                          height: 24,
                          width: 24,
                          fit: BoxFit.cover,
                        ),
                      )
                    else if (selectedImage.value is String)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.network(
                          selectedImage.value,
                          height: 24,
                          width: 24,
                          fit: BoxFit.cover,
                        ),
                      ),
                    const Gap(10),
                    const Text(
                      'Foto',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                onCancel: () => selectedImage.value = null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
