import 'dart:async';

import 'package:adhdo_it_mob/data/models/task_model.dart';
import 'package:adhdo_it_mob/helpers/toast_helper.dart';
import 'package:adhdo_it_mob/l10n/app_localizations.dart';
import 'package:adhdo_it_mob/providers/task_in_progress_providers.dart';
import 'package:adhdo_it_mob/ui/screens/task_in_progress/widgets/%D1%81onfirm_%D1%81omplete_task_bottom_sheet.dart';
import 'package:adhdo_it_mob/ui/screens/task_in_progress/widgets/animated_timer_ring.dart';
import 'package:adhdo_it_mob/ui/screens/task_in_progress/widgets/complete_button.dart';
import 'package:adhdo_it_mob/ui/screens/task_in_progress/widgets/expandable_blur_text.dart';
import 'package:adhdo_it_mob/ui/screens/task_in_progress/widgets/notification_toggle.dart';
import 'package:adhdo_it_mob/ui/screens/task_in_progress/widgets/pause_play_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ResultOnTaskInProgressModel {
  final TaskModel model;
  final bool isPaused;

  ResultOnTaskInProgressModel(this.model, {this.isPaused = true});
}

class TaskInProgressScreen extends StatefulHookConsumerWidget {
  const TaskInProgressScreen(this.model, {super.key});

  final TaskModel model;

  @override
  ConsumerState<TaskInProgressScreen> createState() =>
      _TaskInProgressScreenState();

  static _TaskInProgressScreenState of(BuildContext context) {
    return context.findAncestorStateOfType<_TaskInProgressScreenState>()!;
  }
}

class _TaskInProgressScreenState extends ConsumerState<TaskInProgressScreen>
    with WidgetsBindingObserver {
  late TaskModel model = widget.model;
  late final bool isStopwatchMode = model.durationInSeconds == null;

  bool isPaused = false;
  final remaining = ValueNotifier<Duration>(Duration.zero);
  Timer? timer;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);

    remaining.value = Duration(
      seconds: model.updatedSeconds ?? model.durationInSeconds ?? 0,
    );

    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!isPaused) {
        if (isStopwatchMode) {
          remaining.value = remaining.value + const Duration(seconds: 1);
        } else {
          if (remaining.value.inSeconds > 0) {
            remaining.value = remaining.value - const Duration(seconds: 1);
          }
          if (remaining.value.inSeconds <= 0) {
            timer?.cancel();
          }
        }
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(taskInProgressProvider.notifier).startTask(model.id);
    });
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    timer?.cancel();

    remaining.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached ||
        state == AppLifecycleState.resumed) {
      if (!isPaused) {
        ref
            .read(taskInProgressProvider.notifier)
            .pauseTask(model.id, remaining.value.inSeconds);
      }
      setState(() {
        isPaused = !isPaused;
      });
    }
  }

  String formatDuration(Duration duration) {
    final hours = duration.inHours.toString().padLeft(2, '0');
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$hours:$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (!isPaused) {
          showToast(
            context,
            alignment: Alignment.topCenter,
            type: ToastificationType.warning,
            msg: '⛔ You can’t leave until you pause or complete the task.',
          );

          return false;
        }

        Navigator.pop(
          context,
          ResultOnTaskInProgressModel(
            model.copyWith(updatedSeconds: remaining.value.inSeconds),
            isPaused: true,
          ),
        );
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF0D0D0D), Color(0xFF1A1A1A)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Image.asset(
                'assets/images/focus_background_mountain_night.png',
                fit: BoxFit.fitHeight,
                width: double.infinity,
                alignment: Alignment.center,
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Gap(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (!isPaused) {
                              showToast(
                                context,
                                alignment: Alignment.topCenter,
                                type: ToastificationType.warning,
                                msg:
                                    '⛔ You can’t leave until you pause or complete the task.',
                              );
                              return;
                            }

                            Navigator.pop(
                              context,
                              ResultOnTaskInProgressModel(
                                model.copyWith(
                                  updatedSeconds: remaining.value.inSeconds,
                                ),
                                isPaused: true,
                              ),
                            );
                          },

                          child: Row(
                            children: [
                              const Gap(5),
                              SvgPicture.asset(
                                'assets/svg/arrow_back.svg',
                                color: Colors.white,
                              ),
                              Text(
                                Strings.of(context).myTask,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Gap(16),
                    ExpandableBlurText(text: model.title),
                    Spacer(),
                    ValueListenableBuilder<Duration>(
                      valueListenable: remaining,
                      builder: (context, value, _) {
                        return Container(
                          height: 318,
                          width: 318,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.white),
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(7.5),
                          child: Container(
                            width: 303,
                            height: 303,
                            decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.white),
                              shape: BoxShape.circle,
                            ),
                            padding: EdgeInsets.all(8),
                            alignment: Alignment.center,
                            child: AnimatedTimerRing(
                              remaining: value,
                              total:
                                  isStopwatchMode
                                      ? null
                                      : Duration(
                                        seconds: model.durationInSeconds ?? 0,
                                      ),
                              child: Text(
                                formatDuration(value),
                                style: const TextStyle(
                                  fontSize: 54,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    Spacer(),
                    Row(
                      spacing: 8,
                      children: [
                        Expanded(
                          child: CompleteButton(
                            onTap: () async {
                              final result = await showModalBottomSheet(
                                context: context,
                                backgroundColor: Colors.transparent,
                                isScrollControlled: true,
                                builder: (context) {
                                  return CompleteTaskConfirmSheet();
                                },
                              );
                              if (result == true) {
                                ref
                                    .read(taskInProgressProvider.notifier)
                                    .completeTask(
                                      model.id,
                                      remaining.value.inSeconds,
                                    );
                                Navigator.pop(
                                  context,
                                  ResultOnTaskInProgressModel(
                                    model,
                                    isPaused: false,
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                        Expanded(
                          child: PausePlayButton(
                            onTap: () {
                              if (!isPaused) {
                                ref
                                    .read(taskInProgressProvider.notifier)
                                    .pauseTask(
                                      model.id,
                                      remaining.value.inSeconds,
                                    );
                              }
                              setState(() {
                                isPaused = !isPaused;
                              });
                            },
                            isPause: isPaused,
                          ),
                        ),
                      ],
                    ),
                    Gap(59),
                    // NotificationToggle(),
                    Gap(32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
