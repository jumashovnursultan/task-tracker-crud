import 'package:to_do/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String formatDate(DateTime date, {bool isHasDayafterTomorrow = true}) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final target = DateTime(date.year, date.month, date.day);

  final diff = target.difference(today).inDays;

  if (diff == 0) {
    return 'Today';
  } else if (diff == 1) {
    return 'Tomorrow';
  } else if (diff == 2 && isHasDayafterTomorrow) {
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

String timeAgo(BuildContext context, DateTime date) {
  final DateTime now = DateTime.now();
  final Duration difference = now.difference(date);

  if (difference.inSeconds < 10) {
    return Strings.of(context).now;
  } else if (difference.inSeconds < 60) {
    return Strings.of(context).secondsAgo(difference.inSeconds);
  } else if (difference.inMinutes < 60) {
    return Strings.of(context).minutesAgo(difference.inMinutes);
  } else if (difference.inHours < 24) {
    return Strings.of(context).hoursAgo(difference.inHours);
  } else if (difference.inDays < 7) {
    return Strings.of(context).daysAgo(difference.inDays);
  } else if (difference.inDays < 30) {
    return Strings.of(context).weeksAgo((difference.inDays / 7).round());
  } else if (difference.inDays < 365) {
    return Strings.of(context).monthsAgo((difference.inDays / 30).round());
  } else {
    return Strings.of(context).yearsAgo((difference.inDays / 365).round());
  }
}
