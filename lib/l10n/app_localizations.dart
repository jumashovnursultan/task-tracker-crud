import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of Strings
/// returned by `Strings.of(context)`.
///
/// Applications need to include `Strings.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: Strings.localizationsDelegates,
///   supportedLocales: Strings.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the Strings.supportedLocales
/// property.
abstract class Strings {
  Strings(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static Strings of(BuildContext context) {
    return Localizations.of<Strings>(context, Strings)!;
  }

  static const LocalizationsDelegate<Strings> delegate = _StringsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// No description provided for @welcomeTo.
  ///
  /// In en, this message translates to:
  /// **'Welcome to'**
  String get welcomeTo;

  /// No description provided for @loginToStart.
  ///
  /// In en, this message translates to:
  /// **'Login to start'**
  String get loginToStart;

  /// No description provided for @getCode.
  ///
  /// In en, this message translates to:
  /// **'Get code'**
  String get getCode;

  /// No description provided for @enterYourEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get enterYourEmail;

  /// No description provided for @enterPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter phone number'**
  String get enterPhoneNumber;

  /// No description provided for @enterValidEmailAddress.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address'**
  String get enterValidEmailAddress;

  /// No description provided for @numberIsNotLong.
  ///
  /// In en, this message translates to:
  /// **'The number is not long enough'**
  String get numberIsNotLong;

  /// No description provided for @youCanEnterOnlyRussianOrKyrgyzNumbers.
  ///
  /// In en, this message translates to:
  /// **'You can enter only Russian (+7) or Kyrgyz (+996) numbers'**
  String get youCanEnterOnlyRussianOrKyrgyzNumbers;

  /// No description provided for @somethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get somethingWentWrong;

  /// No description provided for @loginIn.
  ///
  /// In en, this message translates to:
  /// **'Login in'**
  String get loginIn;

  /// No description provided for @enterPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter password'**
  String get enterPassword;

  /// No description provided for @myTask.
  ///
  /// In en, this message translates to:
  /// **'My task'**
  String get myTask;

  /// No description provided for @enterCode.
  ///
  /// In en, this message translates to:
  /// **'Enter code'**
  String get enterCode;

  /// No description provided for @weSentCode.
  ///
  /// In en, this message translates to:
  /// **'We have sent a confirmation code to the {email}'**
  String weSentCode(Object email);

  /// No description provided for @resendCode.
  ///
  /// In en, this message translates to:
  /// **'Resend the code'**
  String get resendCode;

  /// No description provided for @weWillSendCode.
  ///
  /// In en, this message translates to:
  /// **'We will send the code again in'**
  String get weWillSendCode;

  /// No description provided for @help.
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get help;

  /// No description provided for @allTask.
  ///
  /// In en, this message translates to:
  /// **'All task'**
  String get allTask;

  /// No description provided for @addTask.
  ///
  /// In en, this message translates to:
  /// **'Add task'**
  String get addTask;

  /// No description provided for @now.
  ///
  /// In en, this message translates to:
  /// **'now'**
  String get now;

  /// No description provided for @secondsAgo.
  ///
  /// In en, this message translates to:
  /// **'{t, plural, one{{t} second ago} few{{t} seconds ago} many{{t} seconds ago} other{{t} seconds ago}}'**
  String secondsAgo(num t);

  /// No description provided for @minutesAgo.
  ///
  /// In en, this message translates to:
  /// **'{t, plural, one{{t} minute ago} few{{t} minutes ago} many{{t} minutes ago} other{{t} minutes ago}}'**
  String minutesAgo(num t);

  /// No description provided for @hoursAgo.
  ///
  /// In en, this message translates to:
  /// **'{t, plural, one{{t} hour ago} few{{t} hours ago} many{{t} hours ago} other{{t} hours ago}}'**
  String hoursAgo(num t);

  /// No description provided for @daysAgo.
  ///
  /// In en, this message translates to:
  /// **'{t, plural, one{{t} day ago} few{{t} days ago} many{{t} days ago} other{{t} days ago}}'**
  String daysAgo(num t);

  /// No description provided for @weeksAgo.
  ///
  /// In en, this message translates to:
  /// **'{t, plural, one{{t} week ago} few{{t} weeks ago} many{{t} weeks ago} other{{t} weeks ago}}'**
  String weeksAgo(num t);

  /// No description provided for @monthsAgo.
  ///
  /// In en, this message translates to:
  /// **'{t, plural, one{{t} month ago} few{{t} months ago} many{{t} months ago} other{{t} months ago}}'**
  String monthsAgo(num t);

  /// No description provided for @yearsAgo.
  ///
  /// In en, this message translates to:
  /// **'{t, plural, one{{t} year ago} few{{t} years ago} many{{t} years ago} other{{t} years ago}}'**
  String yearsAgo(num t);
}

class _StringsDelegate extends LocalizationsDelegate<Strings> {
  const _StringsDelegate();

  @override
  Future<Strings> load(Locale locale) {
    return SynchronousFuture<Strings>(lookupStrings(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_StringsDelegate old) => false;
}

Strings lookupStrings(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return StringsEn();
  }

  throw FlutterError(
    'Strings.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
