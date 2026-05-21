// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Void';

  @override
  String get appDescription =>
      'Ваше личное пространство для безопасного и бесперебойного общения';

  @override
  String get paletteBrand => 'Бренд';

  @override
  String get paletteCoffee => 'Кофе';

  @override
  String get paletteOcean => 'Океан';

  @override
  String get paletteRose => 'Роза';

  @override
  String get paletteForest => 'Лес';

  @override
  String get greeting => 'С возвращением';

  @override
  String get greetingDescription => 'Погрузись в цифровую тишину';

  @override
  String get continueAction => 'Продолжить';

  @override
  String get or => 'Или';

  @override
  String get logInWithPass => 'Войти с паролем';

  @override
  String get logInWithLogin => 'Войти с Логином/Почтой';

  @override
  String get forgotPassword => 'Забыли пароль?';

  @override
  String get dontHaveAcc => 'Нет аккаунта?';

  @override
  String get singUp => 'Зарегистрироваться';

  @override
  String get logIn => 'Войти';

  @override
  String get loginOrEmailLabel => 'Логин или почта';

  @override
  String get loginOrEmailHint => 'Ваш логин или email';

  @override
  String get loginPasswordLabel => 'Пароль';

  @override
  String get loginPasswordHint => 'Ваш пароль';

  @override
  String get loginIdentifierRequired => 'Введите логин или почту';

  @override
  String get loginIdentifierTooLong => 'Не больше 254 символов';

  @override
  String get confirmPasswordLabel => 'Подтвердите пароль';

  @override
  String get confirmPasswordHint => 'Повторите пароль';

  @override
  String get confirmPasswordRequired => 'Подтвердите пароль';

  @override
  String get confirmPasswordIsNotMatching => 'Пароли не совпадают';

  @override
  String get loginIdentifierInvalidEmail => 'Введите корректный email';

  @override
  String get loginIdentifierInvalidLoginLength => 'Логин: от 3 до 64 символов';

  @override
  String get loginIdentifierInvalidLoginChars =>
      'В логине допустимы буквы, цифры, _ и -';

  @override
  String get loginPasswordRequired => 'Введите пароль';

  @override
  String get loginPasswordLength => 'Пароль: от 8 до 128 символов';

  @override
  String get loginPasswordLetterAndDigit => 'В пароле нужны буква и цифра';

  @override
  String get loginInvalidCredential => 'Неверный логин или пароль';

  @override
  String get networkError =>
      'Не удалось подключиться. Проверьте интернет и повторите попытку.';

  @override
  String get loginEmailCodeInvalid =>
      'Неверный код. Проверьте цифры и попробуйте снова.';

  @override
  String get loginEmailCodeExpired =>
      'Срок действия кода истёк. Запросите новый.';

  @override
  String get loginEmailCodeAttemptsExceeded =>
      'Слишком много попыток. Запросите новый код.';

  @override
  String get registerEmailLabel => 'Почта';

  @override
  String get registerEmailHint => 'friend@void.net';

  @override
  String get registerLoginLabel => 'Логин';

  @override
  String get registerLoginHint => 'cosmo_wanderer';

  @override
  String get registerLoginPrivacyHelper =>
      'Только для входа в аккаунт, другие пользователи его не увидят';

  @override
  String get registerPasswordHint => 'Туманность42';

  @override
  String get registerConfirmPasswordHint => 'Туманность42';

  @override
  String get registerEmailRequired => 'Введите email';

  @override
  String get createAccount => 'Создать аккаунт';

  @override
  String get createAccountDescription =>
      'Окунитесь в безмолвную пустоту защищенной связи';

  @override
  String get alreadyHaveAnAccount => 'Уже есть аккаунт?';

  @override
  String get iAgreeto => 'Я согласен с';

  @override
  String get policy => 'Политика конфиденциальности';

  @override
  String get verifyEmailTitle => 'Подтвердите почту';

  @override
  String get verifyEmailCodeInstruction =>
      'Введите 4-значный код, отправленный на';

  @override
  String get verifyEmailSubmit => 'Подтвердить';

  @override
  String get verifyEmailDidNotReceive => 'Не получили код?';

  @override
  String get verifyEmailResendCode => 'Отправить код снова';

  @override
  String get verifyEmailCodeRequired => 'Введите код подтверждения';

  @override
  String get verifyEmailCodeIncomplete => 'Введите все 4 цифры';

  @override
  String get verifyEmailCodeInvalid => 'Код должен состоять только из цифр';

  @override
  String get profileSetupMainText => 'Последний шаг';

  @override
  String get profileSetupSecondText =>
      'Завершите настройку вашего профиля чтобы присоединиться к void';

  @override
  String get profileSetupUsernameLabel => 'Юзернейм';

  @override
  String get profileSetupUsernameHint => 'username';

  @override
  String get profileSetupDisplayNameLabel => 'Отображаемое имя';

  @override
  String get profileSetupDisplayNameHint => 'Артур Морган';

  @override
  String get profileSetupHintText =>
      'Ваш юзернейм и отображаемое имя публичные. Вы можете изменить из позже в настройках';

  @override
  String get completeSetup => 'Завершить настройку';

  @override
  String get startChatting => 'Начать общение';

  @override
  String get codeSent => 'Письмо отправлено!';
}
