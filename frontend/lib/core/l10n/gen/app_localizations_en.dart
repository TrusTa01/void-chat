// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Void';

  @override
  String get paletteBrand => 'Brand';

  @override
  String get paletteCoffee => 'Coffee';

  @override
  String get paletteOcean => 'Ocean';

  @override
  String get paletteRose => 'Rose';

  @override
  String get paletteForest => 'Forest';

  @override
  String get greeting => 'Welcome back';

  @override
  String get greetingDescription => 'Step into the digital silence';

  @override
  String get continueAction => 'Continue';

  @override
  String get or => 'or';

  @override
  String get loginWithPass => 'Log in with password';

  @override
  String get loginWithLogin => 'Log in with Login/Email';

  @override
  String get forgotPassword => 'Forgot password?';

  @override
  String get dontHaveAcc => 'Don\'t have an account';

  @override
  String get singUp => 'Sing up';

  @override
  String get logIn => 'Log in';

  @override
  String get loginOrEmailLabel => 'Login or email';

  @override
  String get loginOrEmailHint => 'Your login or email';

  @override
  String get loginPasswordLabel => 'Password';

  @override
  String get loginPasswordHint => 'Your password';

  @override
  String get loginIdentifierRequired => 'Use your login or email';

  @override
  String get loginIdentifierTooLong => 'Must be at most 254 characters';

  @override
  String get loginIdentifierInvalidEmail => 'Enter a valid email address';

  @override
  String get loginIdentifierInvalidLoginLength =>
      'Login must be 3–64 characters';

  @override
  String get loginIdentifierInvalidLoginChars =>
      'Login may only use letters, digits, underscore, and hyphen';

  @override
  String get loginPasswordRequired => 'Enter your password';

  @override
  String get loginPasswordLength => 'Password must be 8–128 characters';

  @override
  String get loginPasswordLetterAndDigit =>
      'Password must include at least one letter and one number';
}
