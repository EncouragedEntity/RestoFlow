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

  /// `QR code wasnot read. Try again`
  String get qr_scan_error {
    return Intl.message(
      'QR code wasnot read. Try again',
      name: 'qr_scan_error',
      desc: '',
      args: [],
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

  /// `Save changes`
  String get save_changes {
    return Intl.message(
      'Save changes',
      name: 'save_changes',
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

  /// `Empty here. For now (:`
  String get no_dishes {
    return Intl.message(
      'Empty here. For now (:',
      name: 'no_dishes',
      desc: '',
      args: [],
    );
  }

  /// `Crickets sing here...`
  String get empty_here {
    return Intl.message(
      'Crickets sing here...',
      name: 'empty_here',
      desc: '',
      args: [],
    );
  }

  /// `It includes:`
  String get dish_content {
    return Intl.message(
      'It includes:',
      name: 'dish_content',
      desc: '',
      args: [],
    );
  }

  /// `Cooking time:`
  String get cooking_time {
    return Intl.message(
      'Cooking time:',
      name: 'cooking_time',
      desc: '',
      args: [],
    );
  }

  /// `Your order`
  String get your_order {
    return Intl.message(
      'Your order',
      name: 'your_order',
      desc: '',
      args: [],
    );
  }

  /// `You should scan qr first`
  String get scan_first {
    return Intl.message(
      'You should scan qr first',
      name: 'scan_first',
      desc: '',
      args: [],
    );
  }

  /// `Go to scan page`
  String get go_to_scan {
    return Intl.message(
      'Go to scan page',
      name: 'go_to_scan',
      desc: '',
      args: [],
    );
  }

  /// `You should login first`
  String get login_first {
    return Intl.message(
      'You should login first',
      name: 'login_first',
      desc: '',
      args: [],
    );
  }

  /// `Go to login page`
  String get go_to_login {
    return Intl.message(
      'Go to login page',
      name: 'go_to_login',
      desc: '',
      args: [],
    );
  }

  /// `Go to menu page`
  String get go_to_menu {
    return Intl.message(
      'Go to menu page',
      name: 'go_to_menu',
      desc: '',
      args: [],
    );
  }

  /// `Order`
  String get order {
    return Intl.message(
      'Order',
      name: 'order',
      desc: '',
      args: [],
    );
  }

  /// `Checkout`
  String get checkout {
    return Intl.message(
      'Checkout',
      name: 'checkout',
      desc: '',
      args: [],
    );
  }

  /// `Save card details?`
  String get want_to_save_card {
    return Intl.message(
      'Save card details?',
      name: 'want_to_save_card',
      desc: '',
      args: [],
    );
  }

  /// `Pay partially`
  String get pay_partially {
    return Intl.message(
      'Pay partially',
      name: 'pay_partially',
      desc: '',
      args: [],
    );
  }

  /// `Send receipt to email`
  String get send_reciept {
    return Intl.message(
      'Send receipt to email',
      name: 'send_reciept',
      desc: '',
      args: [],
    );
  }

  /// `Payment successful!`
  String get payment_successful {
    return Intl.message(
      'Payment successful!',
      name: 'payment_successful',
      desc: '',
      args: [],
    );
  }

  /// `Payment failed. Please try again.`
  String get payment_failure {
    return Intl.message(
      'Payment failed. Please try again.',
      name: 'payment_failure',
      desc: '',
      args: [],
    );
  }

  /// `Pay`
  String get pay {
    return Intl.message(
      'Pay',
      name: 'pay',
      desc: '',
      args: [],
    );
  }

  /// `Confirm order`
  String get confirm_order {
    return Intl.message(
      'Confirm order',
      name: 'confirm_order',
      desc: '',
      args: [],
    );
  }

  /// `Do you really want to order? You can't cancel it`
  String get confirm_order_text {
    return Intl.message(
      'Do you really want to order? You can\'t cancel it',
      name: 'confirm_order_text',
      desc: '',
      args: [],
    );
  }

  /// `Card details`
  String get card_details {
    return Intl.message(
      'Card details',
      name: 'card_details',
      desc: '',
      args: [],
    );
  }

  /// `Confirm deletion`
  String get confirm_deletion {
    return Intl.message(
      'Confirm deletion',
      name: 'confirm_deletion',
      desc: '',
      args: [],
    );
  }

  /// `Do you really want to clear your card details?`
  String get confirm_card_deletion_text {
    return Intl.message(
      'Do you really want to clear your card details?',
      name: 'confirm_card_deletion_text',
      desc: '',
      args: [],
    );
  }

  /// `Clear`
  String get clear {
    return Intl.message(
      'Clear',
      name: 'clear',
      desc: '',
      args: [],
    );
  }

  /// `Clear details`
  String get clear_details {
    return Intl.message(
      'Clear details',
      name: 'clear_details',
      desc: '',
      args: [],
    );
  }

  /// `Reset table`
  String get reset_table {
    return Intl.message(
      'Reset table',
      name: 'reset_table',
      desc: '',
      args: [],
    );
  }

  /// `Card number`
  String get card_number {
    return Intl.message(
      'Card number',
      name: 'card_number',
      desc: '',
      args: [],
    );
  }

  /// `Expiration date`
  String get expiration_date {
    return Intl.message(
      'Expiration date',
      name: 'expiration_date',
      desc: '',
      args: [],
    );
  }

  /// `Price to pay`
  String get desired_price {
    return Intl.message(
      'Price to pay',
      name: 'desired_price',
      desc: '',
      args: [],
    );
  }

  /// `Enter valid card number`
  String get validation_card_number {
    return Intl.message(
      'Enter valid card number',
      name: 'validation_card_number',
      desc: '',
      args: [],
    );
  }

  /// `Your orders`
  String get your_orders {
    return Intl.message(
      'Your orders',
      name: 'your_orders',
      desc: '',
      args: [],
    );
  }

  /// `Sum paid`
  String get sum_paid {
    return Intl.message(
      'Sum paid',
      name: 'sum_paid',
      desc: '',
      args: [],
    );
  }

  /// `Tips`
  String get tips {
    return Intl.message(
      'Tips',
      name: 'tips',
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
