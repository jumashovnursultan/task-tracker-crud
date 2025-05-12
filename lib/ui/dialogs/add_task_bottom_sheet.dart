import 'dart:io';
import 'dart:ui';

import 'package:adhdo_it_mob/data/models/task_model.dart';
import 'package:adhdo_it_mob/helpers/date_helpers.dart';
import 'package:adhdo_it_mob/helpers/toast_helper.dart';
import 'package:adhdo_it_mob/providers/task_providers.dart';
import 'package:adhdo_it_mob/ui/dialogs/attach_file_bottom_sheet.dart';
import 'package:adhdo_it_mob/ui/dialogs/date_picker_bottom_sheet.dart';
import 'package:adhdo_it_mob/ui/dialogs/duration_time_bottom_sheet.dart';
import 'package:adhdo_it_mob/ui/dialogs/loading.dart';
import 'package:adhdo_it_mob/ui/dialogs/reminder_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class AddTaskBottomSheet extends HookConsumerWidget {
  const AddTaskBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textController = useTextEditingController();
    final focusNode = useFocusNode();

    final priority = useState(0);
    final selectedDate = useState<DateTime?>(null);
    final selectedDuration = useState<Duration?>(null);
    final selectedReminderTime = useState<DateTime?>(null);
    final selectedImage = useState<File?>(null);

    useEffect(() {
      Future.delayed(Duration(milliseconds: 200), () {
        focusNode.requestFocus();
      });
      focusNode.addListener(() {
        // if (focusNode.)
      });
      return null;
    }, []);

    return SafeArea(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 4.0),
        child: Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      TextFormField(
                        focusNode: focusNode,
                        controller: textController,
                        maxLines: null,
                        minLines: 1,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (v) async {
                          if (selectedDate.value == null ||
                              selectedDuration.value == null ||
                              selectedReminderTime.value == null ||
                              priority.value == 0) {
                            showToast(
                              context,
                              type: ToastificationType.warning,
                              alignment: Alignment.topCenter,
                              msg:
                                  'Please complete all required fields: title, date, duration, reminder, and select a priority level.',
                            );
                            focusNode.requestFocus();
                            return;
                          }
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return const Loading();
                            },
                          );
                          final response = await ref.read(
                            createTaskProvider(
                              TaskModel(
                                id: -1,
                                title: v,
                                date: selectedDate.value!,
                                durationInSeconds:
                                    selectedDuration.value!.inSeconds,
                                priority: priority.value,
                                imageFile: selectedImage.value,
                              ),
                            ).future,
                          );
                          if (response.isSuccessful) {
                            Navigator.of(context)
                              ..pop()
                              ..pop(response.result);
                          } else {
                            if (response.statusCode == 413) {
                              showToast(
                                context,
                                type: ToastificationType.error,
                                msg:
                                    'Image is too large. Please choose a smaller one.',
                              );
                            } else {
                              showToast(
                                context,
                                type: ToastificationType.error,
                                msg: response.errorData.toString(),
                              );
                            }
                            Navigator.of(context).pop();
                          }
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          filled: true,
                          fillColor: Colors.transparent,
                          hintText: '|Add task',
                          hintStyle: TextStyle(
                            color: Color(0xFF92918A),
                            fontSize: 16,
                          ),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                        ),
                      ),
                      Gap(10),
                      SizedBox(
                        height: 24,
                        child: ListView.separated(
                          padding: EdgeInsets.zero,
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          separatorBuilder: (context, index) => Gap(16),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                priority.value = index + 1;
                              },
                              child:
                                  index < priority.value
                                      ? SvgPicture.asset(
                                        'assets/svg/star_filled.svg',
                                        color: Color(0xFFFF4C4C),
                                      )
                                      : SvgPicture.asset(
                                        'assets/svg/star_outline.svg',
                                      ),
                            );
                          },
                        ),
                      ),
                      Gap(15),
                    ],
                  ),
                ),
                SizedBox(
                  height: 44,
                  child: ListView(
                    padding: EdgeInsets.symmetric(horizontal: 6),
                    scrollDirection: Axis.horizontal,
                    children: [
                      Gap(13),
                      Bounceable(
                        onTap: () async {
                          final date = await showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            barrierColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(30),
                              ),
                            ),
                            builder:
                                (_) => DateBottomSheet(
                                  initialDate: selectedDate.value,
                                ),
                          );
                          if (date is DateTime) {
                            selectedDate.value = date;
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color:
                                selectedDate.value != null
                                    ? Color(0xFFF5F5F5)
                                    : null,
                          ),
                          child: Row(
                            children: [
                              if (selectedDate.value != null) Gap(12),
                              SvgPicture.asset('assets/svg/calendar.svg'),
                              if (selectedDate.value != null) ...[
                                Gap(4),
                                Text(
                                  formatDate(selectedDate.value!),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Gap(16),
                                Bounceable(
                                  onTap: () {
                                    selectedDate.value = null;
                                  },
                                  child: Container(
                                    height: 24,
                                    width: 24,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                    child: SvgPicture.asset(
                                      'assets/svg/cancel.svg',
                                    ),
                                  ),
                                ),
                                Gap(12),
                              ],
                            ],
                          ),
                        ),
                      ),

                      Gap(selectedDate.value != null ? 8 : 27),
                      Bounceable(
                        onTap: () async {
                          final duration = await showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            barrierColor: Colors.transparent,
                            backgroundColor: Colors.transparent,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(30),
                              ),
                            ),
                            builder:
                                (_) => DurationTimeBottomSheet(
                                  selectedDuration.value,
                                ),
                          );

                          if (duration is Duration) {
                            selectedDuration.value = duration;
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color:
                                selectedDuration.value != null
                                    ? Color(0xFFF5F5F5)
                                    : null,
                          ),
                          child: Row(
                            children: [
                              if (selectedDuration.value != null) Gap(12),
                              SvgPicture.asset('assets/svg/watch.svg'),
                              if (selectedDuration.value != null) ...[
                                Gap(4),
                                Text(
                                  formatDuration(selectedDuration.value!),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Gap(16),
                                Bounceable(
                                  onTap: () {
                                    selectedDuration.value = null;
                                  },
                                  child: Container(
                                    height: 24,
                                    width: 24,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                    child: SvgPicture.asset(
                                      'assets/svg/cancel.svg',
                                    ),
                                  ),
                                ),
                                Gap(12),
                              ],
                            ],
                          ),
                        ),
                      ),
                      Gap(selectedDuration.value != null ? 8 : 20),

                      Bounceable(
                        onTap: () async {
                          final time = await showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            barrierColor: Colors.transparent,
                            backgroundColor: Colors.transparent,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(30),
                              ),
                            ),
                            builder:
                                (_) => ReminderBottomSheet(
                                  selectedReminderTime.value,
                                ),
                          );

                          if (time is DateTime) {
                            selectedReminderTime.value = time;
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color:
                                selectedReminderTime.value != null
                                    ? Color(0xFFF5F5F5)
                                    : null,
                          ),
                          child: Row(
                            children: [
                              if (selectedReminderTime.value != null) Gap(5),
                              SvgPicture.asset('assets/svg/bell.svg'),
                              if (selectedReminderTime.value != null) ...[
                                Text(
                                  'At ${DateFormat('HH:mm').format(selectedReminderTime.value!)}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Gap(16),
                                Bounceable(
                                  onTap: () {
                                    selectedReminderTime.value = null;
                                  },
                                  child: Container(
                                    height: 24,
                                    width: 24,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                    child: SvgPicture.asset(
                                      'assets/svg/cancel.svg',
                                    ),
                                  ),
                                ),
                                Gap(12),
                              ],
                            ],
                          ),
                        ),
                      ),
                      Gap(8),
                      Bounceable(
                        onTap: () async {
                          final image = await showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            barrierColor: Colors.transparent,
                            backgroundColor: Colors.transparent,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(30),
                              ),
                            ),
                            builder: (_) => AttachFileBottomSheet(),
                          );

                          if (image is File) {
                            selectedImage.value = image;
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color:
                                selectedImage.value != null
                                    ? Color(0xFFF5F5F5)
                                    : null,
                          ),
                          child: Row(
                            children: [
                              if (selectedImage.value != null) ...[
                                Gap(12),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.file(
                                    selectedImage.value!,

                                    height: 24,
                                    width: 24,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Gap(6),
                              ] else
                                SvgPicture.asset('assets/svg/attach.svg'),
                              if (selectedImage.value != null) ...[
                                Text(
                                  'Foto',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Gap(12),
                                Bounceable(
                                  onTap: () {
                                    selectedImage.value = null;
                                  },
                                  child: Container(
                                    height: 24,
                                    width: 24,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                    child: SvgPicture.asset(
                                      'assets/svg/cancel.svg',
                                    ),
                                  ),
                                ),
                                Gap(12),
                              ],
                            ],
                          ),
                        ),
                      ),
                      // Gap(20),
                      // Container(
                      //   height: 44,
                      //   width: 44,
                      //   decoration: BoxDecoration(
                      //     shape: BoxShape.circle,
                      //     color: Color(0xFFF5F5F5),
                      //   ),
                      //   alignment: Alignment.center,
                      //   child: SizedBox(
                      //     height: 23,
                      //     width: 24,
                      //     child: SvgPicture.asset('assets/svg/microphone.svg'),
                      //   ),
                      // ),
                      Gap(10),
                    ],
                  ),
                ),
                Gap(16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
