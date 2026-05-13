import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

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
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ru'),
  ];

  /// App title in app bar and system
  ///
  /// In en, this message translates to:
  /// **'Void'**
  String get appTitle;

  /// Built-in palette name: Brand
  ///
  /// In en, this message translates to:
  /// **'Brand'**
  String get paletteBrand;

  /// Built-in palette name: Coffee
  ///
  /// In en, this message translates to:
  /// **'Coffee'**
  String get paletteCoffee;

  /// Built-in palette name: Ocean
  ///
  /// In en, this message translates to:
  /// **'Ocean'**
  String get paletteOcean;

  /// Built-in palette name: Rose
  ///
  /// In en, this message translates to:
  /// **'Rose'**
  String get paletteRose;

  /// Built-in palette name: Forest
  ///
  /// In en, this message translates to:
  /// **'Forest'**
  String get paletteForest;

  /// Main text in login screen
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get greeting;

  /// A text under a greeting in login screen
  ///
  /// In en, this message translates to:
  /// **'Step into the digital silence'**
  String get greetingDescription;

  /// Continue action
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueAction;

  /// A divider between blocks
  ///
  /// In en, this message translates to:
  /// **'or'**
  String get or;

  /// A text of a button in login screen to login with password
  ///
  /// In en, this message translates to:
  /// **'Log in with password'**
  String get loginWithPass;

  /// A text of a button in login screen to login with a login or an email
  ///
  /// In en, this message translates to:
  /// **'Log in with Login/Email'**
  String get loginWithLogin;

  /// A redirect to a password recovery with a password mode in login screen
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPassword;

  /// Redirect to sing up screen if user doesnt have an account
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account'**
  String get dontHaveAcc;

  /// Sing up redirect
  ///
  /// In en, this message translates to:
  /// **'Sing up'**
  String get singUp;

  /// A text for a button to log in into app
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get logIn;

  /// Label for the login identifier field (POST /auth/login identifier)
  ///
  /// In en, this message translates to:
  /// **'Login or email'**
  String get loginOrEmailLabel;

  /// Hint for the login identifier field
  ///
  /// In en, this message translates to:
  /// **'Your login or email'**
  String get loginOrEmailHint;

  /// Label for the password field on login
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get loginPasswordLabel;

  /// Hint for the password field
  ///
  /// In en, this message translates to:
  /// **'Your password'**
  String get loginPasswordHint;

  /// Validation: empty identifier
  ///
  /// In en, this message translates to:
  /// **'Use your login or email'**
  String get loginIdentifierRequired;

  /// Validation: identifier exceeds backend max (email)
  ///
  /// In en, this message translates to:
  /// **'Must be at most 254 characters'**
  String get loginIdentifierTooLong;

  /// Validation: identifier looks like email but format is invalid
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email address'**
  String get loginIdentifierInvalidEmail;

  /// Validation: non-email identifier length out of range
  ///
  /// In en, this message translates to:
  /// **'Login must be 3–64 characters'**
  String get loginIdentifierInvalidLoginLength;

  /// Validation: non-email identifier charset
  ///
  /// In en, this message translates to:
  /// **'Login may only use letters, digits, underscore, and hyphen'**
  String get loginIdentifierInvalidLoginChars;

  /// Validation: empty password
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get loginPasswordRequired;

  /// Validation: password length (matches registration rules)
  ///
  /// In en, this message translates to:
  /// **'Password must be 8–128 characters'**
  String get loginPasswordLength;

  /// Validation: password complexity (matches registration rules)
  ///
  /// In en, this message translates to:
  /// **'Password must include at least one letter and one number'**
  String get loginPasswordLetterAndDigit;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
