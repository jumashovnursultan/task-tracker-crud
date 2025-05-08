import 'package:adhdo_it_mob/data/models/task_model.dart';
import 'package:adhdo_it_mob/helpers/date_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class TaskCard extends StatelessWidget {
  const TaskCard(
    this.model, {
    super.key,
    this.onUndoTap,
    this.canUndo = false,
    this.onDeleteTap,
    this.onEditTap,
  });

  final TaskModel model;
  final VoidCallback? onUndoTap;
  final VoidCallback? onDeleteTap;
  final VoidCallback? onEditTap;
  final bool canUndo;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        image:
            model.backgroundImage != null
                ? DecorationImage(
                  image: NetworkImage(model.backgroundImage!),
                  fit: BoxFit.cover,
                )
                : null,
        color:
            model.backgroundImage == null
                ? getColorByPriority(model.priority)
                : Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      alignment: Alignment.center,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            model.title,
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
          ),
          Spacer(),
          Container(
            height: 44,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Gap(12),
                SvgPicture.asset('assets/svg/calendar.svg'),
                Gap(8),
                Text(formatDate(model.date), style: TextStyle(fontSize: 16)),
                Gap(16),
              ],
            ),
          ),
          Gap(12),
          Container(
            height: 44,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Gap(12),
                SvgPicture.asset('assets/svg/watch.svg'),
                Gap(8),
                Text(
                  formatDuration(model.durationInSeconds),
                  style: TextStyle(fontSize: 16),
                ),
                Gap(16),
              ],
            ),
          ),
          Gap(12),
          Container(
            height: 44,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Gap(12),
                ...List.generate(5, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: SvgPicture.asset(
                      'assets/svg/star_${index < model.priority ? 'filled' : 'outline'}.svg',
                    ),
                  );
                }),
                Gap(16),
              ],
            ),
          ),
          Gap(40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Bounceable(
                onTap: onUndoTap,

                child: Opacity(
                  opacity: canUndo ? 1 : 0.5,
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    alignment: Alignment.center,
                    child: SvgPicture.asset('assets/svg/undo_icon.svg'),
                  ),
                ),
              ),
              Gap(16),
              Bounceable(
                onTap: onEditTap,
                child: Container(
                  height: 56,
                  width: 56,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  alignment: Alignment.center,
                  child: SvgPicture.asset('assets/svg/pencil.svg'),
                ),
              ),
              Gap(16),
              Bounceable(
                onTap: onDeleteTap,
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  alignment: Alignment.center,
                  child: SvgPicture.asset('assets/svg/delete.svg'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color getColorByPriority(int priority) {
    switch (priority) {
      case 5:
        return Color(0xFFC894C4);
      case 4:
        return Color(0xFFFECD81);
      case 3:
        return Color(0xFFFCF6A0);
      case 2:
        return Color(0xFFC4E0A6);
      case 1:
        return Color(0xFF96C8ED);
      case 0:
        return Color(0xFFF09A9B);
      default:
        return Colors.cyanAccent;
    }
  }

  String formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;

    final hours = minutes ~/ 60;
    final remainingMinutes = minutes % 60;

    if (hours > 0 && remainingMinutes > 0) {
      return '$hours hour${hours > 1 ? 's' : ''} $remainingMinutes minute${remainingMinutes > 1 ? 's' : ''}';
    } else if (hours > 0) {
      return '$hours hour${hours > 1 ? 's' : ''}';
    } else if (minutes > 0) {
      return '$minutes minute${minutes > 1 ? 's' : ''}';
    } else {
      return '$remainingSeconds second${remainingSeconds > 1 ? 's' : ''}';
    }
  }
}
