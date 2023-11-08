// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static String m0(errorText) =>
      "Check your internet connection or try again later.\n ${errorText}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "add_to_order": MessageLookupByLibrary.simpleMessage("Add to order"),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "confirm_log_out":
            MessageLookupByLibrary.simpleMessage("Confirm logout"),
        "confirm_password":
            MessageLookupByLibrary.simpleMessage("Confirm password"),
        "connection_error": m0,
        "cooking_time": MessageLookupByLibrary.simpleMessage("Cooking time:"),
        "details": MessageLookupByLibrary.simpleMessage("Dish details"),
        "dish_content": MessageLookupByLibrary.simpleMessage("It includes:"),
        "dont_have_account":
            MessageLookupByLibrary.simpleMessage("Don\'t have an account?"),
        "email": MessageLookupByLibrary.simpleMessage("Email"),
        "error": MessageLookupByLibrary.simpleMessage("error"),
        "firstname": MessageLookupByLibrary.simpleMessage("First name"),
        "go_to_login": MessageLookupByLibrary.simpleMessage("Go to login page"),
        "go_to_scan": MessageLookupByLibrary.simpleMessage("Go to scan page"),
        "have_account":
            MessageLookupByLibrary.simpleMessage("Already have an account?"),
        "hello": MessageLookupByLibrary.simpleMessage("Hello,"),
        "history_tab": MessageLookupByLibrary.simpleMessage("History"),
        "lastname": MessageLookupByLibrary.simpleMessage("Last name"),
        "log_in": MessageLookupByLibrary.simpleMessage("Log in"),
        "log_out": MessageLookupByLibrary.simpleMessage("Log out"),
        "login_first":
            MessageLookupByLibrary.simpleMessage("You should login first"),
        "menu_tab": MessageLookupByLibrary.simpleMessage("Menu"),
        "new_password": MessageLookupByLibrary.simpleMessage("New password"),
        "no_dishes":
            MessageLookupByLibrary.simpleMessage("Empty here. For now (:"),
        "order": MessageLookupByLibrary.simpleMessage("Your order"),
        "order_tab": MessageLookupByLibrary.simpleMessage("Order"),
        "password": MessageLookupByLibrary.simpleMessage("Password"),
        "profile_tab": MessageLookupByLibrary.simpleMessage("Profile"),
        "qr_tab": MessageLookupByLibrary.simpleMessage("Scan QR"),
        "save_changes": MessageLookupByLibrary.simpleMessage("Save changes"),
        "scan_first":
            MessageLookupByLibrary.simpleMessage("You should scan qr first"),
        "sign_up": MessageLookupByLibrary.simpleMessage("Sign up"),
        "stranger": MessageLookupByLibrary.simpleMessage("Stranger"),
        "tap_to_scan": MessageLookupByLibrary.simpleMessage("Tap to scan"),
        "validation_email":
            MessageLookupByLibrary.simpleMessage("Please, enter your email"),
        "validation_email_valid":
            MessageLookupByLibrary.simpleMessage("Please, enter valid email"),
        "validation_password":
            MessageLookupByLibrary.simpleMessage("Please, enter your password"),
        "validation_password_valid": MessageLookupByLibrary.simpleMessage(
            "Password must be at least 8 characters"),
        "validation_re_password": MessageLookupByLibrary.simpleMessage(
            "Please, confirm your password"),
        "validation_re_password_valid":
            MessageLookupByLibrary.simpleMessage("Passwords do not match"),
        "want_to_log_out": MessageLookupByLibrary.simpleMessage(
            "Do you really want to log out?")
      };
}
