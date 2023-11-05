// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `error`
  String get error {
    return Intl.message(
      'error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `Check your internet connection or try again later.\n {errorText}`
  String connection_error(Object errorText) {
    return Intl.message(
      'Check your internet connection or try again later.\n $errorText',
      name: 'connection_error',
      desc: '',
      args: [errorText],
    );
  }

  /// `Tap to scan`
  String get tap_to_scan {
    return Intl.message(
      'Tap to scan',
      name: 'tap_to_scan',
      desc: '',
      args: [],
    );
  }

  /// `Menu`
  String get menu_tab {
    return Intl.message(
      'Menu',
      name: 'menu_tab',
      desc: '',
      args: [],
    );
  }

  /// `Order`
  String get order_tab {
    return Intl.message(
      'Order',
      name: 'order_tab',
      desc: '',
      args: [],
    );
  }

  /// `Scan QR`
  String get qr_tab {
    return Intl.message(
      'Scan QR',
      name: 'qr_tab',
      desc: '',
      args: [],
    );
  }

  /// `History`
  String get history_tab {
    return Intl.message(
      'History',
      name: 'history_tab',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile_tab {
    return Intl.message(
      'Profile',
      name: 'profile_tab',
      desc: '',
      args: [],
    );
  }

  /// `Log in`
  String get log_in {
    return Intl.message(
      'Log in',
      name: 'log_in',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Confirm password`
  String get confirm_password {
    return Intl.message(
      'Confirm password',
      name: 'confirm_password',
      desc: '',
      args: [],
    );
  }

  /// `Confirm logout`
  String get confirm_log_out {
    return Intl.message(
      'Confirm logout',
      name: 'confirm_log_out',
      desc: '',
      args: [],
    );
  }

  /// `Do you really want to log out?`
  String get want_to_log_out {
    return Intl.message(
      'Do you really want to log out?',
      name: 'want_to_log_out',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Log out`
  String get log_out {
    return Intl.message(
      'Log out',
      name: 'log_out',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `First name`
  String get firstname {
    return Intl.message(
      'First name',
      name: 'firstname',
      desc: '',
      args: [],
    );
  }

  /// `Last name`
  String get lastname {
    return Intl.message(
      'Last name',
      name: 'lastname',
      desc: '',
      args: [],
    );
  }

  /// `New password`
  String get new_password {
    return Intl.message(
      'New password',
      name: 'new_password',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get dont_have_account {
    return Intl.message(
      'Don\'t have an account?',
      name: 'dont_have_account',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get have_account {
    return Intl.message(
      'Already have an account?',
      name: 'have_account',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get sign_up {
    return Intl.message(
      'Sign up',
      name: 'sign_up',
      desc: '',
      args: [],
    );
  }

  /// `Please, enter your email`
  String get validation_email {
    return Intl.message(
      'Please, enter your email',
      name: 'validation_email',
      desc: '',
      args: [],
    );
  }

  /// `Please, enter valid email`
  String get validation_email_valid {
    return Intl.message(
      'Please, enter valid email',
      name: 'validation_email_valid',
      desc: '',
      args: [],
    );
  }

  /// `Please, enter your password`
  String get validation_password {
    return Intl.message(
      'Please, enter your password',
      name: 'validation_password',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 8 characters`
  String get validation_password_valid {
    return Intl.message(
      'Password must be at least 8 characters',
      name: 'validation_password_valid',
      desc: '',
      args: [],
    );
  }

  /// `Please, confirm your password`
  String get validation_re_password {
    return Intl.message(
      'Please, confirm your password',
      name: 'validation_re_password',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get validation_re_password_valid {
    return Intl.message(
      'Passwords do not match',
      name: 'validation_re_password_valid',
      desc: '',
      args: [],
    );
  }

  /// `Hello,`
  String get hello {
    return Intl.message(
      'Hello,',
      name: 'hello',
      desc: '',
      args: [],
    );
  }

  /// `Stranger`
  String get stranger {
    return Intl.message(
      'Stranger',
      name: 'stranger',
      desc: '',
      args: [],
    );
  }

  /// `Add to order`
  String get add_to_order {
    return Intl.message(
      'Add to order',
      name: 'add_to_order',
      desc: '',
      args: [],
    );
  }

  /// `Dish details`
  String get details {
    return Intl.message(
      'Dish details',
      name: 'details',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'uk'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
