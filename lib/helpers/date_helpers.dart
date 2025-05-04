import 'package:intl/intl.dart';

String formatDate(DateTime date) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final target = DateTime(date.year, date.month, date.day);

  final diff = target.difference(today).inDays;

  if (diff == 0) {
    return 'Today';
  } else if (diff == 1) {
    return 'Tomorrow';
  } else if (diff == 2) {
    return 'Day after tomorrow';
  } else {
    return DateFormat('d MMMM yyyy', 'en').format(date);
  }
}

String formatDuration(Duration duration) {
  final hours = duration.inHours;
  final minutes = duration.inMinutes % 60;
  final seconds = duration.inSeconds % 60;

  final mm = minutes.toString().padLeft(2, '0');
  final ss = seconds.toString().padLeft(2, '0');

  if (hours > 0) {
    final hh = hours.toString().padLeft(2, '0');
    return '$hh:$mm:$ss';
  } else {
    return '$mm:$ss';
  }
}
