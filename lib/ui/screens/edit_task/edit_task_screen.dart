import 'package:adhdo_it_mob/data/models/task_model.dart';
import 'package:adhdo_it_mob/helpers/date_helpers.dart';
import 'package:adhdo_it_mob/helpers/toast_helper.dart';
import 'package:adhdo_it_mob/l10n/app_localizations.dart';
import 'package:adhdo_it_mob/providers/task_providers.dart';
import 'package:adhdo_it_mob/ui/dialogs/loading.dart';
import 'package:adhdo_it_mob/ui/screens/edit_task/widgets/edit_task_date_selector.dart';
import 'package:adhdo_it_mob/ui/screens/edit_task/widgets/edit_task_duration_selector.dart';
import 'package:adhdo_it_mob/ui/screens/edit_task/widgets/edit_task_image_selector.dart';
import 'package:adhdo_it_mob/ui/screens/edit_task/widgets/edit_task_priority_selector.dart';
import 'package:adhdo_it_mob/ui/screens/edit_task/widgets/edit_task_reminder_selector.dart';
import 'package:adhdo_it_mob/ui/screens/edit_task/widgets/edit_task_title_field.dart';
import 'package:adhdo_it_mob/ui/screens/edit_task/widgets/delete_task_confirm_sheet.dart';
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
    final priority = useState(model.priority);
    final selectedDate = useState<DateTime?>(model.date);
    final selectedDuration = useState<Duration?>(
      model.durationInSeconds != null
          ? Duration(seconds: model.durationInSeconds!)
          : null,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
                  GestureDetector(
                    onTap: () async {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return const Loading();
                        },
                      );
                      final response = await ref.read(
                        editTaskProvider(
                          TaskModel(
                            id: model.id,
                            title: textEditController.text,
                            date: selectedDate.value,
                            durationInSeconds:
                                selectedDuration.value?.inSeconds,
                            updatedSeconds: selectedDuration.value?.inSeconds,
                            priority: priority.value,
                            imageFile: selectedImage.value,
                          ),
                        ).future,
                      );
                      if (response.isSuccessful) {
                        Navigator.pop(context);
                        Navigator.pop(context, response.result!);
                      } else {
                        if (response.statusCode == 413) {
                          showToast(
                            context,
                            type: ToastificationType.error,
                            alignment: Alignment.topCenter,
                            msg:
                                'Image is too large. Please choose a smaller one.',
                          );
                        } else {
                          showToast(
                            context,
                            type: ToastificationType.error,
                            alignment: Alignment.topCenter,
                            msg: response.errorData.toString(),
                          );
                        }
                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      'Save',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
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
              EditTaskImageSelector(selectedImage: selectedImage),
              Spacer(),
              if (model.createdAt != null)
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () async {
                    final result = await showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      isScrollControlled: true,
                      builder: (context) {
                        return DeleteTaskConfirmSheet();
                      },
                    );
                    if (result == true) {
                      Navigator.pop(context, model.id);
                    }
                  },
                  child: SizedBox(
                    height: 40,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Text(
                          'Task created ${timeAgo(context, model.createdAt!)}'
                              .toLowerCase(),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: SvgPicture.asset('assets/svg/delete.svg'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              Gap(15),
            ],
          ),
        ),
      ),
    );
  }
}
