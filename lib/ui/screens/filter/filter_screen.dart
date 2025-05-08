import 'package:adhdo_it_mob/data/models/task_model.dart';
import 'package:adhdo_it_mob/helpers/toast_helper.dart';
import 'package:adhdo_it_mob/l10n/strings.dart';
import 'package:adhdo_it_mob/providers/task_providers.dart';
import 'package:adhdo_it_mob/ui/dialogs/filter_dialog.dart';
import 'package:adhdo_it_mob/ui/screens/filter/widgets/task_list_item.dart';
import 'package:adhdo_it_mob/ui/widgets/empty_task_view.dart';
import 'package:adhdo_it_mob/ui/widgets/server_error_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FilterScreen extends HookConsumerWidget {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initialParams = TaskParamsModel();
    final taskState = ref.watch(taskListProvider(initialParams: initialParams));

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: _HeaderSection()),
            taskState.list.when(
              data: (data) => _buildTaskList(context, ref, data, initialParams),
              error:
                  (_, __) => const SliverFillRemaining(
                    child: Padding(
                      padding: EdgeInsets.only(top: 70),
                      child: ServerErrorView(),
                    ),
                  ),
              loading:
                  () => const SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator.adaptive()),
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskList(
    BuildContext context,
    WidgetRef ref,
    List<TaskModel> data,
    TaskParamsModel initialParams,
  ) {
    if (data.isEmpty) {
      return const SliverFillRemaining(
        child: Padding(
          padding: EdgeInsets.only(top: 70),
          child: EmptyTaskView(),
        ),
      );
    }

    return SliverToBoxAdapter(
      child: ListView.separated(
        itemCount: data.length,
        shrinkWrap: true,
        padding: const EdgeInsets.fromLTRB(11, 10, 11, 21),
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (_, __) => const Gap(20),
        itemBuilder: (context, index) {
          final task = data[index];
          return TaskListItem(
            model: task,
            onDelete: (id) async {
              final response = await ref
                  .read(taskListProvider(initialParams: initialParams).notifier)
                  .deleteTask(id);
              if (!response.isSuccessful) {
                showToast(
                  context,
                  msg: response.errorData.toString(),
                  type: ToastificationType.error,
                );
              }
            },
          );
        },
      ),
    );
  }
}

class _HeaderSection extends HookConsumerWidget {
  const _HeaderSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initialParams = TaskParamsModel();
    final taskState = ref.watch(taskListProvider(initialParams: initialParams));

    return Column(
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
            Bounceable(
              onTap: () async {
                final result = await showDialog(
                  context: context,
                  barrierColor: Colors.transparent,
                  builder:
                      (_) =>
                          FilterDialog(taskFilter: taskState.params.filterType),
                );

                final notifier = ref.read(
                  taskListProvider(initialParams: initialParams).notifier,
                );

                if (result is TaskFilter) {
                  notifier.filter(TaskParamsModel(filterType: result));
                } else if (result is MapEntry<TaskFilter, dynamic>) {
                  final filter = result.key;
                  final value = result.value;

                  if (filter.isByDate) {
                    notifier.filter(
                      TaskParamsModel(filterType: filter, byDate: value),
                    );
                  } else {
                    final time = value as DateTime;
                    final seconds = time.hour * 3600 + time.minute * 60;
                    notifier.filter(
                      TaskParamsModel(filterType: filter, byTime: seconds),
                    );
                  }
                }
              },
              child: Container(
                height: 44,
                width: 215,
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(100),
                ),
                margin: const EdgeInsets.only(right: 24),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      taskState.params.filterType.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SvgPicture.asset('assets/svg/arrow_dropdown.svg'),
                  ],
                ),
              ),
            ),
          ],
        ),
        const Gap(20),
      ],
    );
  }
}
