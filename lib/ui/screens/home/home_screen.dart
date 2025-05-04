import 'package:adhdo_it_mob/l10n/strings.dart';
import 'package:adhdo_it_mob/providers/task_providers.dart';
import 'package:adhdo_it_mob/ui/dialogs/add_task_bottom_sheet.dart';
import 'package:adhdo_it_mob/ui/screens/home/widgets/task_item.dart';
import 'package:adhdo_it_mob/ui/widgets/empty_task_view.dart';
import 'package:adhdo_it_mob/ui/widgets/server_error_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useState(CardSwiperController()).value;
    final taskState = ref.watch(taskListProvider());
    final swipeHistory = useState([]);

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
                  Container(
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
                ],
              ),
              const Gap(16),
              Expanded(
                child: taskState.list.when(
                  data: (data) {
                    if (data.isEmpty) {
                      return const Center(child: EmptyTaskView());
                    }

                    return CardSwiper(
                      controller: controller,
                      cardsCount: data.length,
                      numberOfCardsDisplayed: 3,
                      onSwipe: (index, value, direction) {
                        swipeHistory.value.add(index);

                        return true;
                      },
                      backCardOffset: const Offset(0, -40),
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
                        return TaskItem(
                          key: ValueKey(task.id),
                          task,
                          onUndoTap: () {
                            controller.undo();
                            final lastIndex = swipeHistory.value.lastOrNull;
                            if (lastIndex == null) return;
                            swipeHistory.value.removeAt(lastIndex);
                          },
                          canUndo: swipeHistory.value.isNotEmpty,
                        );
                      },
                    );
                  },
                  error: (error, _) => Center(child: ServerErrorView()),
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
                      onTap: () {
                        showModalBottomSheet(
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

class Example extends StatefulWidget {
  const Example({super.key});

  @override
  State<Example> createState() => _ExamplePageState();
}

class _ExamplePageState extends State<Example> {
  final CardSwiperController controller = CardSwiperController();

  List<Container> cards = [
    Container(
      alignment: Alignment.center,
      child: const Text('1'),
      color: Colors.blue,
    ),
    Container(
      alignment: Alignment.center,
      child: const Text('2'),
      color: Colors.red,
    ),
    Container(
      alignment: Alignment.center,
      child: const Text('3'),
      color: Colors.purple,
    ),
  ];

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: CardSwiper(
                controller: controller,
                cardsCount: cards.length,
                onSwipe: _onSwipe,
                onUndo: _onUndo,
                numberOfCardsDisplayed: 3,
                backCardOffset: const Offset(40, 40),
                padding: const EdgeInsets.all(24.0),
                cardBuilder:
                    (
                      context,
                      index,
                      horizontalThresholdPercentage,
                      verticalThresholdPercentage,
                    ) => cards[index],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton(
                    onPressed: controller.undo,
                    child: const Icon(Icons.rotate_left),
                  ),
                  FloatingActionButton(
                    onPressed: () => controller.swipe(CardSwiperDirection.left),
                    child: const Icon(Icons.keyboard_arrow_left),
                  ),
                  FloatingActionButton(
                    onPressed:
                        () => controller.swipe(CardSwiperDirection.right),
                    child: const Icon(Icons.keyboard_arrow_right),
                  ),
                  FloatingActionButton(
                    onPressed: () => controller.swipe(CardSwiperDirection.top),
                    child: const Icon(Icons.keyboard_arrow_up),
                  ),
                  FloatingActionButton(
                    onPressed:
                        () => controller.swipe(CardSwiperDirection.bottom),
                    child: const Icon(Icons.keyboard_arrow_down),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _onSwipe(
    int previousIndex,
    int? currentIndex,
    CardSwiperDirection direction,
  ) {
    debugPrint(
      'The card $previousIndex was swiped to the ${direction.name}. Now the card $currentIndex is on top',
    );
    return true;
  }

  bool _onUndo(
    int? previousIndex,
    int currentIndex,
    CardSwiperDirection direction,
  ) {
    debugPrint('The card $currentIndex was undod from the ${direction.name}');
    return true;
  }
}
