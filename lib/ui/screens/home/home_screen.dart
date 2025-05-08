import 'package:adhdo_it_mob/config/router/app_route.dart';
import 'package:adhdo_it_mob/l10n/strings.dart';
import 'package:adhdo_it_mob/providers/task_providers.dart';
import 'package:adhdo_it_mob/ui/dialogs/add_task_bottom_sheet.dart';

import 'package:adhdo_it_mob/ui/screens/home/widgets/task_card.dart';
import 'package:adhdo_it_mob/ui/screens/task_in_progress/task_in_progress_screen.dart';
import 'package:adhdo_it_mob/ui/widgets/empty_task_view.dart';
import 'package:adhdo_it_mob/ui/widgets/server_error_view.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useState(CardSwiperController()).value;
    final taskState = ref.watch(taskListProvider());
    final swipeHistory = useState<List<int>>([]);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              const Gap(32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Strings.of(context).myTask,
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          DateFormat('EEEE, MMMM d').format(DateTime.now()),
                          style: TextStyle(
                            color: Color(0xFF92918A),
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Bounceable(
                    onTap: () {
                      context.push(Routes.filter());
                    },
                    child: Container(
                      height: 44,
                      width: 129,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SvgPicture.asset('assets/svg/all_tasks_icon.svg'),
                          Text(
                            Strings.of(context).allTask,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(16),
              Expanded(
                child: taskState.list.when(
                  data: (data) {
                    if (data.isEmpty) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 70),
                          child: EmptyTaskView(),
                        ),
                      );
                    }

                    return CardSwiper(
                      controller: controller,
                      cardsCount: data.length,
                      numberOfCardsDisplayed: data.length < 3 ? data.length : 3,
                      backCardOffset: Offset(0, -40),

                      onSwipe: (index, value, direction) async {
                        swipeHistory.value.add(index);

                        if (direction.name == 'left') {
                          final result = await context.push(
                            Routes.taskInProgress(),
                            extra: data[index],
                          );
                          if (result is ResultOnTaskInProgressModel &&
                              !result.isPaused) {
                            ref
                                .read(taskListProvider().notifier)
                                .deleteTask(result.model.id);
                            final index = swipeHistory.value.firstWhereOrNull(
                              (e) => e == result.model.id,
                            );
                            if (index != -1 && index != null) {
                              swipeHistory.value.removeAt(index);
                            }
                          } else if (result is ResultOnTaskInProgressModel &&
                              result.isPaused) {
                            ref
                                .read(taskListProvider().notifier)
                                .updateTask(result.model);
                          }
                        }
                        return true;
                      },

                      allowedSwipeDirection: AllowedSwipeDirection.symmetric(
                        horizontal: true,
                      ),

                      padding: EdgeInsets.only(top: 22),
                      cardBuilder: (
                        context,
                        index,
                        horizontalThresholdPercentage,
                        verticalThresholdPercentage,
                      ) {
                        final task = data[index];
                        return TaskCard(
                          key: ValueKey(task.id),
                          task,
                          onUndoTap: () {
                            controller.undo();
                            final lastIndex = swipeHistory.value.lastOrNull;
                            if (lastIndex == null) return;
                            swipeHistory.value.removeAt(lastIndex);
                          },
                          onDeleteTap: () {
                            ref
                                .read(taskListProvider().notifier)
                                .deleteTask(task.id);
                          },
                          onEditTap: () {
                            context.push(Routes.editTask(), extra: task);
                          },
                          canUndo: swipeHistory.value.isNotEmpty,
                        );
                      },
                    );
                  },
                  error:
                      (error, _) => Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 70),
                          child: ServerErrorView(),
                        ),
                      ),
                  loading:
                      () => Center(
                        child: const CircularProgressIndicator.adaptive(),
                      ),
                ),
              ),
              Gap(24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Bounceable(
                      onTap: () async {
                        final taskModel = await showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(30),
                            ),
                          ),
                          builder: (_) => const AddTaskBottomSheet(),
                        );
                        if (taskModel != null) {
                          ref
                              .read(taskListProvider().notifier)
                              .addTask(taskModel);
                        }
                      },
                      child: Container(
                        width: 309,
                        height: 44,
                        decoration: BoxDecoration(
                          color: Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                            width: 1,
                            color: Color(0xFFEEEEEE),
                          ),
                        ),
                        child: Row(
                          children: [
                            Gap(12),
                            SvgPicture.asset('assets/svg/plus.svg'),
                            Gap(8),
                            Text(Strings.of(context).addTask),
                          ],
                        ),
                      ),
                    ),
                  ),

                  Gap(8),
                  Container(
                    height: 44,
                    width: 44,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFF5F5F5),
                    ),
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: 23,
                      width: 24,
                      child: SvgPicture.asset('assets/svg/microphone.svg'),
                    ),
                  ),
                ],
              ),
              Gap(16),
            ],
          ),
        ),
      ),
    );
  }
}
