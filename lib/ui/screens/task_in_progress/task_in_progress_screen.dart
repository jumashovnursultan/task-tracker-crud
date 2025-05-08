import 'dart:async';

import 'package:adhdo_it_mob/data/models/task_model.dart';
import 'package:adhdo_it_mob/helpers/toast_helper.dart';
import 'package:adhdo_it_mob/l10n/strings.dart';
import 'package:adhdo_it_mob/providers/task_in_progress_providers.dart';
import 'package:adhdo_it_mob/ui/screens/task_in_progress/widgets/%D1%81onfirm_%D1%81omplete_task_bottom_sheet.dart';
import 'package:adhdo_it_mob/ui/screens/task_in_progress/widgets/animated_timer_ring.dart';
import 'package:adhdo_it_mob/ui/screens/task_in_progress/widgets/complete_button.dart';
import 'package:adhdo_it_mob/ui/screens/task_in_progress/widgets/expandable_blur_text.dart';
import 'package:adhdo_it_mob/ui/screens/task_in_progress/widgets/notification_toggle.dart';
import 'package:adhdo_it_mob/ui/screens/task_in_progress/widgets/pause_play_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached) {
      // ref.read(taskInProgressProvider.notifier).pauseTask(model.id);
    } else if (state == AppLifecycleState.resumed) {}
  }

  @override
  Widget build(BuildContext context) {
    final taskInProgressState = ref.watch(taskInProgressProvider);
    final isPaused = useState(false);
    final remaining = useState<Duration>(Duration.zero);
    final timer = useRef<Timer?>(null);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        ref.read(taskInProgressProvider.notifier).startTask(model.id);
      });
      Duration calculateRemainingDuration(TaskModel model) {
        final now = DateTime.now();

        if (model.startedAt == null) {
          return Duration(seconds: model.durationInSeconds);
        }

        final start = model.startedAt!;
        final passed =
            model.pausedAt != null
                ? model.pausedAt!.difference(start).inSeconds
                : now.difference(start).inSeconds;

        final left = model.durationInSeconds - passed;
        return Duration(seconds: left > 0 ? left : 0);
      }

      remaining.value = calculateRemainingDuration(model);

      timer.value?.cancel();
      timer.value = Timer.periodic(const Duration(seconds: 1), (_) {
        if (!isPaused.value && remaining.value.inSeconds > 0) {
          remaining.value -= const Duration(seconds: 1);
        }
        if (remaining.value.inSeconds <= 0) {
          timer.value?.cancel();
        }
      });

      return () => timer.value?.cancel();
    }, []);

    String formatDuration(Duration duration) {
      final minutes = duration.inMinutes
          .remainder(60)
          .toString()
          .padLeft(2, '0');
      final seconds = duration.inSeconds
          .remainder(60)
          .toString()
          .padLeft(2, '0');
      return "$minutes:$seconds";
    }

    return WillPopScope(
      onWillPop: () async {
        if (!isPaused.value) {
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
            model.copyWith(
              startedAt: model.startedAt ?? taskInProgressState.startedAt,
              pausedAt: DateTime.now(),
            ),
            isPaused: true,
          ),
        );
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Image.asset(
              'assets/images/focus_background_mountain_night.png',
              fit: BoxFit.cover,
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
                            if (!isPaused.value) {
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
                                  startedAt:
                                      model.startedAt ??
                                      taskInProgressState.startedAt,
                                  pausedAt: DateTime.now(),
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
                    Container(
                      height: 318,
                      width: 318,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Color.fromRGBO(255, 255, 255, 1),
                        ),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(7.5),
                      child: Container(
                        width: 303,
                        height: 303,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: Color.fromRGBO(255, 255, 255, 1),
                          ),
                          shape: BoxShape.circle,
                        ),
                        padding: EdgeInsets.all(8),
                        alignment: Alignment.center,
                        child: AnimatedTimerRing(
                          remaining: remaining.value,
                          total: Duration(seconds: model.durationInSeconds),
                          child: Text(
                            formatDuration(remaining.value),
                            style: TextStyle(
                              fontSize: 54,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
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
                                    .completeTask(model.id);
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
                              if (!isPaused.value) {
                                ref
                                    .read(taskInProgressProvider.notifier)
                                    .pauseTask(model.id);
                              }
                              isPaused.value = !isPaused.value;
                            },
                            isPause: isPaused.value,
                          ),
                        ),
                      ],
                    ),
                    Gap(59),
                    NotificationToggle(),
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
