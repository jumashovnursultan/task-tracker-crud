import 'dart:io';

import 'package:adhdo_it_mob/data/models/task_model.dart';
import 'package:adhdo_it_mob/helpers/date_helpers.dart';
import 'package:adhdo_it_mob/l10n/strings.dart';
import 'package:adhdo_it_mob/ui/screens/edit_task/widgets/edit_task_date_selector.dart';
import 'package:adhdo_it_mob/ui/screens/edit_task/widgets/edit_task_duration_selector.dart';
import 'package:adhdo_it_mob/ui/screens/edit_task/widgets/edit_task_image_selector.dart';
import 'package:adhdo_it_mob/ui/screens/edit_task/widgets/edit_task_priority_selector.dart';
import 'package:adhdo_it_mob/ui/screens/edit_task/widgets/edit_task_reminder_selector.dart';
import 'package:adhdo_it_mob/ui/screens/edit_task/widgets/edit_task_title_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EditTaskScreen extends HookConsumerWidget {
  const EditTaskScreen(this.model, {super.key});

  final TaskModel model;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textEditController = useTextEditingController(text: model.title);
    final priority = useState(0);
    final selectedDate = useState<DateTime?>(model.date);
    final selectedDuration = useState<Duration?>(
      Duration(seconds: model.durationInSeconds),
    );
    final selectedReminderTime = useState<DateTime?>(model.date);
    final selectedImage = useState<dynamic>(model.backgroundImage);
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
              Gap(16),
              EditTaskTitleField(controller: textEditController),
              Gap(16),
              EditTaskPrioritySelector(priority: priority),
              Gap(8),
              EditTaskDateSelector(selectedDate: selectedDate),
              Gap(8),
              EditTaskDurationSelector(selectedDuration: selectedDuration),
              Gap(8),
              EditTaskReminderSelector(
                selectedReminderTime: selectedReminderTime,
              ),
              Gap(8),
              EditTaskImageSelector(
                selectedImage: selectedImage,
                onClear: () => selectedImage.value = null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
