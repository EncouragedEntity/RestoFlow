// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a uk locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'uk';

  static String m0(errorText) =>
      "Перевірте з\'єднання з інтернетом або спробуйте потім.\n ${errorText}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "add_to_order":
            MessageLookupByLibrary.simpleMessage("Додати до замовлення"),
        "cancel": MessageLookupByLibrary.simpleMessage("Відміна"),
        "confirm_log_out":
            MessageLookupByLibrary.simpleMessage("Підтвердження виходу"),
        "confirm_password":
            MessageLookupByLibrary.simpleMessage("Підтвердіть пароль"),
        "connection_error": m0,
        "details": MessageLookupByLibrary.simpleMessage("Деталі про страву"),
        "dont_have_account":
            MessageLookupByLibrary.simpleMessage("Не маєте акаунта?"),
        "email": MessageLookupByLibrary.simpleMessage("Пошта"),
        "error": MessageLookupByLibrary.simpleMessage("Помилка"),
        "firstname": MessageLookupByLibrary.simpleMessage("Ім\'я"),
        "have_account": MessageLookupByLibrary.simpleMessage("Маєте акаунт?"),
        "hello": MessageLookupByLibrary.simpleMessage("Вітаємо,"),
        "history_tab": MessageLookupByLibrary.simpleMessage("Історія"),
        "lastname": MessageLookupByLibrary.simpleMessage("Прізвище"),
        "log_in": MessageLookupByLibrary.simpleMessage("Увійти"),
        "log_out": MessageLookupByLibrary.simpleMessage("Вийти"),
        "menu_tab": MessageLookupByLibrary.simpleMessage("Меню"),
        "order_tab": MessageLookupByLibrary.simpleMessage("Замовити"),
        "password": MessageLookupByLibrary.simpleMessage("Пароль"),
        "profile_tab": MessageLookupByLibrary.simpleMessage("Профіль"),
        "qr_tab": MessageLookupByLibrary.simpleMessage("Сканувати"),
        "sign_up": MessageLookupByLibrary.simpleMessage("Зареєструватись"),
        "stranger": MessageLookupByLibrary.simpleMessage("Незнайомцю"),
        "tap_to_scan":
            MessageLookupByLibrary.simpleMessage("Натисніть, щоб відсканувати"),
        "validation_email": MessageLookupByLibrary.simpleMessage(
            "Будь ласка, введіть вашу пошту"),
        "validation_email_valid": MessageLookupByLibrary.simpleMessage(
            "Будь ласка, введіть дійсну пошту"),
        "validation_password":
            MessageLookupByLibrary.simpleMessage("Будь ласка, введіть пароль"),
        "validation_password_valid": MessageLookupByLibrary.simpleMessage(
            "Пароль повинен бути не менше 8 символів"),
        "validation_re_password": MessageLookupByLibrary.simpleMessage(
            "Будь ласка, підтвердіть ваш пароль"),
        "validation_re_password_valid":
            MessageLookupByLibrary.simpleMessage("Паролі не збігаються"),
        "want_to_log_out":
            MessageLookupByLibrary.simpleMessage("Ви дійсно хочете вийти?")
      };
}
