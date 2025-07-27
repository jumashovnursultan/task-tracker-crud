// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class StringsEn extends Strings {
  StringsEn([String locale = 'en']) : super(locale);

  @override
  String get welcomeTo => 'Welcome to';

  @override
  String get loginToStart => 'Login to start';

  @override
  String get getCode => 'Get code';

  @override
  String get enterYourEmail => 'Enter your email';

  @override
  String get enterPhoneNumber => 'Enter phone number';

  @override
  String get enterValidEmailAddress => 'Please enter a valid email address';

  @override
  String get numberIsNotLong => 'The number is not long enough';

  @override
  String get youCanEnterOnlyRussianOrKyrgyzNumbers =>
      'You can enter only Russian (+7) or Kyrgyz (+996) numbers';

  @override
  String get somethingWentWrong => 'Something went wrong';

  @override
  String get loginIn => 'Login in';

  @override
  String get enterPassword => 'Enter password';

  @override
  String get myTask => 'My task';

  @override
  String get enterCode => 'Enter code';

  @override
  String weSentCode(Object email) {
    return 'We have sent a confirmation code to the $email';
  }

  @override
  String get resendCode => 'Resend the code';

  @override
  String get weWillSendCode => 'We will send the code again in';

  @override
  String get help => 'Help';

  @override
  String get allTask => 'All task';

  @override
  String get addTask => 'Add task';

  @override
  String get now => 'now';

  @override
  String secondsAgo(num t) {
    String _temp0 = intl.Intl.pluralLogic(
      t,
      locale: localeName,
      other: '$t seconds ago',
      many: '$t seconds ago',
      few: '$t seconds ago',
      one: '$t second ago',
    );
    return '$_temp0';
  }

  @override
  String minutesAgo(num t) {
    String _temp0 = intl.Intl.pluralLogic(
      t,
      locale: localeName,
      other: '$t minutes ago',
      many: '$t minutes ago',
      few: '$t minutes ago',
      one: '$t minute ago',
    );
    return '$_temp0';
  }

  @override
  String hoursAgo(num t) {
    String _temp0 = intl.Intl.pluralLogic(
      t,
      locale: localeName,
      other: '$t hours ago',
      many: '$t hours ago',
      few: '$t hours ago',
      one: '$t hour ago',
    );
    return '$_temp0';
  }

  @override
  String daysAgo(num t) {
    String _temp0 = intl.Intl.pluralLogic(
      t,
      locale: localeName,
      other: '$t days ago',
      many: '$t days ago',
      few: '$t days ago',
      one: '$t day ago',
    );
    return '$_temp0';
  }

  @override
  String weeksAgo(num t) {
    String _temp0 = intl.Intl.pluralLogic(
      t,
      locale: localeName,
      other: '$t weeks ago',
      many: '$t weeks ago',
      few: '$t weeks ago',
      one: '$t week ago',
    );
    return '$_temp0';
  }

  @override
  String monthsAgo(num t) {
    String _temp0 = intl.Intl.pluralLogic(
      t,
      locale: localeName,
      other: '$t months ago',
      many: '$t months ago',
      few: '$t months ago',
      one: '$t month ago',
    );
    return '$_temp0';
  }

  @override
  String yearsAgo(num t) {
    String _temp0 = intl.Intl.pluralLogic(
      t,
      locale: localeName,
      other: '$t years ago',
      many: '$t years ago',
      few: '$t years ago',
      one: '$t year ago',
    );
    return '$_temp0';
  }
}
