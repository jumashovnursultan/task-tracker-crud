import 'package:adhdo_it_mob/data/models/task_model.dart';
import 'package:adhdo_it_mob/helpers/date_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class TaskListItem extends StatelessWidget {
  const TaskListItem({super.key, required this.model, this.onDelete});

  final TaskModel model;
  final Function(int)? onDelete;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(bottom: 0.3),
                  decoration: BoxDecoration(
                    color: Color(0xFFDD4D41),

                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ],
          ),
        ),
        Slidable(
          key: UniqueKey(),
          direction: Axis.horizontal,

          endActionPane: ActionPane(
            motion: const BehindMotion(),
            extentRatio: 0.18,

            children: [
              CustomSlidableAction(
                backgroundColor: Color(0xFFDD4D41),
                autoClose: false,

                onPressed: (BuildContext context) {
                  onDelete?.call(model.id);
                },
                borderRadius: BorderRadius.circular(20),
                child: SvgPicture.asset(
                  'assets/svg/delete.svg',
                  color: Colors.white,
                ),
              ),
            ],
          ),
          child: Builder(
            builder: (context) {
              SlidableController? _controller = Slidable.of(context);
              return ValueListenableBuilder<int>(
                valueListenable:
                    _controller?.direction ?? ValueNotifier<int>(0),
                builder: (context, value, _) {
                  var _borderRadius = BorderRadius.horizontal(
                    right: Radius.circular(value == -1 ? 20 : 20),
                    left: Radius.circular(value == 1 ? 20 : 20),
                  );
                  return Container(
                    height: 90,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,

                      borderRadius: _borderRadius,
                    ),
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(model.title),
                        Spacer(),
                        Row(
                          children: [
                            PriorityStars(
                              filledCount: model.priority,
                              filledColor: getColorByPriority(model.priority),
                            ),
                            Gap(22),
                            SvgPicture.asset(
                              'assets/svg/calendar.svg',
                              height: 16,
                              width: 16,
                            ),
                            Gap(4),
                            Text(
                              formatDate(model.date),
                              style: TextStyle(color: Color(0xFF92918A)),
                            ),
                            Gap(22),
                            SvgPicture.asset(
                              'assets/svg/watch.svg',
                              height: 16,
                              width: 16,
                            ),
                            Gap(4),
                            Text(
                              'At ${DateFormat('HH:mm').format(model.date)}',
                              style: TextStyle(color: Color(0xFF92918A)),
                            ),
                            Spacer(),
                            SvgPicture.asset(
                              'assets/svg/arrow_forward.svg',
                              height: 24,
                              width: 24,
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Color getColorByPriority(int priority) {
    switch (priority) {
      case 5:
        return Color(0xFFFF4C4C);
      case 4:
        return Color(0xFFFFA500);
      case 3:
        return Color(0xFFFFFF00);
      case 2:
        return Color(0xFFA7E56E);
      case 1:
        return Color(0xFF7BDEF2);
      case 0:
        return Color(0xFFF09A9B);
      default:
        return Colors.cyanAccent;
    }
  }
}

class PriorityStars extends StatelessWidget {
  final int filledCount; // от 0 до 5
  final Color? filledColor;
  final double size;
  final double gap;

  const PriorityStars({
    super.key,
    required this.filledCount,
    this.filledColor,
    this.size = 16,
    this.gap = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (index) {
        final isFilled = index < filledCount;
        return Padding(
          padding: EdgeInsets.only(right: index < 4 ? gap : 0),
          child: SvgPicture.asset(
            isFilled
                ? 'assets/svg/star_filled.svg'
                : 'assets/svg/star_outline.svg',
            width: size,
            height: size,
            color: isFilled ? filledColor : const Color(0xFF9E9E9E),
          ),
        );
      }),
    );
  }
}
