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

  /// `Terms and Conditions`
  String get term_header {
    return Intl.message(
      'Terms and Conditions',
      name: 'term_header',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
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

  /// `New password`
  String get new_password {
    return Intl.message(
      'New password',
      name: 'new_password',
      desc: '',
      args: [],
    );
  }

  /// `Current password`
  String get current_password {
    return Intl.message(
      'Current password',
      name: 'current_password',
      desc: '',
      args: [],
    );
  }

  /// `Password not matched`
  String get password_not_match {
    return Intl.message(
      'Password not matched',
      name: 'password_not_match',
      desc: '',
      args: [],
    );
  }

  /// `Please enter new password to complete the process`
  String get please_update_password {
    return Intl.message(
      'Please enter new password to complete the process',
      name: 'please_update_password',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Verify`
  String get the_verify {
    return Intl.message(
      'Verify',
      name: 'the_verify',
      desc: '',
      args: [],
    );
  }

  /// `Please enter verification code sent via email`
  String get please_enter_code_to_verify {
    return Intl.message(
      'Please enter verification code sent via email',
      name: 'please_enter_code_to_verify',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your email to send the verification code`
  String get please_enter_email_to_send_code_it {
    return Intl.message(
      'Please enter your email to send the verification code',
      name: 'please_enter_email_to_send_code_it',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Signup`
  String get signup {
    return Intl.message(
      'Signup',
      name: 'signup',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Login in To Your `
  String get login_welcome_msg1 {
    return Intl.message(
      'Login in To Your ',
      name: 'login_welcome_msg1',
      desc: '',
      args: [],
    );
  }

  /// `GolCoin Stacking `
  String get login_welcome_msg2 {
    return Intl.message(
      'GolCoin Stacking ',
      name: 'login_welcome_msg2',
      desc: '',
      args: [],
    );
  }

  /// `Platform Account`
  String get login_welcome_msg3 {
    return Intl.message(
      'Platform Account',
      name: 'login_welcome_msg3',
      desc: '',
      args: [],
    );
  }

  /// `Signup `
  String get signup_welcome_msg1 {
    return Intl.message(
      'Signup ',
      name: 'signup_welcome_msg1',
      desc: '',
      args: [],
    );
  }

  /// `GolCoin Stacking `
  String get signup_welcome_msg2 {
    return Intl.message(
      'GolCoin Stacking ',
      name: 'signup_welcome_msg2',
      desc: '',
      args: [],
    );
  }

  /// `New Account`
  String get signup_welcome_msg3 {
    return Intl.message(
      'New Account',
      name: 'signup_welcome_msg3',
      desc: '',
      args: [],
    );
  }

  /// `Your email address`
  String get your_email {
    return Intl.message(
      'Your email address',
      name: 'your_email',
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

  /// `Forget password?`
  String get forget_password {
    return Intl.message(
      'Forget password?',
      name: 'forget_password',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account, `
  String get dont_have_an_account {
    return Intl.message(
      'Don\'t have an account, ',
      name: 'dont_have_an_account',
      desc: '',
      args: [],
    );
  }

  /// `Email address not valid`
  String get email_not_valid {
    return Intl.message(
      'Email address not valid',
      name: 'email_not_valid',
      desc: '',
      args: [],
    );
  }

  /// `Password is not valid`
  String get password_not_valid {
    return Intl.message(
      'Password is not valid',
      name: 'password_not_valid',
      desc: '',
      args: [],
    );
  }

  /// `First name`
  String get first_name {
    return Intl.message(
      'First name',
      name: 'first_name',
      desc: '',
      args: [],
    );
  }

  /// `Last name`
  String get last_name {
    return Intl.message(
      'Last name',
      name: 'last_name',
      desc: '',
      args: [],
    );
  }

  /// `Phone number`
  String get phone_number {
    return Intl.message(
      'Phone number',
      name: 'phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Already registered? `
  String get already_registered {
    return Intl.message(
      'Already registered? ',
      name: 'already_registered',
      desc: '',
      args: [],
    );
  }

  /// `Password dose not match`
  String get password_does_not_match {
    return Intl.message(
      'Password dose not match',
      name: 'password_does_not_match',
      desc: '',
      args: [],
    );
  }

  /// `Weak password`
  String get weak_password_message {
    return Intl.message(
      'Weak password',
      name: 'weak_password_message',
      desc: '',
      args: [],
    );
  }

  /// `Phone number is not valid`
  String get incorrect_phone_number {
    return Intl.message(
      'Phone number is not valid',
      name: 'incorrect_phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Required field`
  String get required_field {
    return Intl.message(
      'Required field',
      name: 'required_field',
      desc: '',
      args: [],
    );
  }

  /// `The user name is incorrect`
  String get incorrect_username {
    return Intl.message(
      'The user name is incorrect',
      name: 'incorrect_username',
      desc: '',
      args: [],
    );
  }

  /// `Invalid code`
  String get invalid_code {
    return Intl.message(
      'Invalid code',
      name: 'invalid_code',
      desc: '',
      args: [],
    );
  }

  /// `Invalid name`
  String get invalid_name {
    return Intl.message(
      'Invalid name',
      name: 'invalid_name',
      desc: '',
      args: [],
    );
  }

  /// `Invalid password`
  String get invalid_password {
    return Intl.message(
      'Invalid password',
      name: 'invalid_password',
      desc: '',
      args: [],
    );
  }

  /// `GolCoin Staking is a simple Platform that helps you to invest and earn interest on your GolCoin assets.\nYour annual interest is paid daily and tracked to the second.`
  String get golCoin_staking_is_a_simple {
    return Intl.message(
      'GolCoin Staking is a simple Platform that helps you to invest and earn interest on your GolCoin assets.\nYour annual interest is paid daily and tracked to the second.',
      name: 'golCoin_staking_is_a_simple',
      desc: '',
      args: [],
    );
  }

  /// `Term and conditions`
  String get term_and_conditions {
    return Intl.message(
      'Term and conditions',
      name: 'term_and_conditions',
      desc: '',
      args: [],
    );
  }

  /// `Collect Your Rewards`
  String get collect_your_rewards {
    return Intl.message(
      'Collect Your Rewards',
      name: 'collect_your_rewards',
      desc: '',
      args: [],
    );
  }

  /// `Connect Your Wallet To Calculate Your Reward`
  String get connect_wallet_desc {
    return Intl.message(
      'Connect Your Wallet To Calculate Your Reward',
      name: 'connect_wallet_desc',
      desc: '',
      args: [],
    );
  }

  /// `Start Your Stake`
  String get start_stake {
    return Intl.message(
      'Start Your Stake',
      name: 'start_stake',
      desc: '',
      args: [],
    );
  }

  /// `Percentage`
  String get percentage {
    return Intl.message(
      'Percentage',
      name: 'percentage',
      desc: '',
      args: [],
    );
  }

  /// `CAP`
  String get cap {
    return Intl.message(
      'CAP',
      name: 'cap',
      desc: '',
      args: [],
    );
  }

  /// `Reward`
  String get reward {
    return Intl.message(
      'Reward',
      name: 'reward',
      desc: '',
      args: [],
    );
  }

  /// `Claim`
  String get claim {
    return Intl.message(
      'Claim',
      name: 'claim',
      desc: '',
      args: [],
    );
  }

  /// `Choose Your GOL Staking Amount`
  String get choose_amount {
    return Intl.message(
      'Choose Your GOL Staking Amount',
      name: 'choose_amount',
      desc: '',
      args: [],
    );
  }

  /// `Choose Your GOGOL Staking Amount`
  String get choose_amount_old {
    return Intl.message(
      'Choose Your GOGOL Staking Amount',
      name: 'choose_amount_old',
      desc: '',
      args: [],
    );
  }

  /// `Features of`
  String get features_of {
    return Intl.message(
      'Features of',
      name: 'features_of',
      desc: '',
      args: [],
    );
  }

  /// `Profit distribution table`
  String get profit_distribution_table {
    return Intl.message(
      'Profit distribution table',
      name: 'profit_distribution_table',
      desc: '',
      args: [],
    );
  }

  /// `Monthly and weekly`
  String get monthly_and_weekly {
    return Intl.message(
      'Monthly and weekly',
      name: 'monthly_and_weekly',
      desc: '',
      args: [],
    );
  }

  /// `it's`
  String get it_s {
    return Intl.message(
      'it\'s',
      name: 'it_s',
      desc: '',
      args: [],
    );
  }

  /// `Just days.`
  String get just_days {
    return Intl.message(
      'Just days.',
      name: 'just_days',
      desc: '',
      args: [],
    );
  }

  /// `Blog`
  String get blog {
    return Intl.message(
      'Blog',
      name: 'blog',
      desc: '',
      args: [],
    );
  }

  /// `Objective`
  String get objective {
    return Intl.message(
      'Objective',
      name: 'objective',
      desc: '',
      args: [],
    );
  }

  /// `RoadMap`
  String get road_map {
    return Intl.message(
      'RoadMap',
      name: 'road_map',
      desc: '',
      args: [],
    );
  }

  /// `Contact us`
  String get contact_us {
    return Intl.message(
      'Contact us',
      name: 'contact_us',
      desc: '',
      args: [],
    );
  }

  /// `Closed`
  String get closed {
    return Intl.message(
      'Closed',
      name: 'closed',
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

  /// `Error while deleting account`
  String get error_delete_account {
    return Intl.message(
      'Error while deleting account',
      name: 'error_delete_account',
      desc: '',
      args: [],
    );
  }

  /// `Your account has been deactivated`
  String get disable_title {
    return Intl.message(
      'Your account has been deactivated',
      name: 'disable_title',
      desc: '',
      args: [],
    );
  }

  /// `Your account has been deactivated, please contact us on email tarek@metagols.com to solve your problem`
  String get disable_description {
    return Intl.message(
      'Your account has been deactivated, please contact us on email tarek@metagols.com to solve your problem',
      name: 'disable_description',
      desc: '',
      args: [],
    );
  }

  /// `Ok`
  String get ok {
    return Intl.message(
      'Ok',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message(
      'English',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// `Arabic`
  String get arabic {
    return Intl.message(
      'Arabic',
      name: 'arabic',
      desc: '',
      args: [],
    );
  }

  /// `before`
  String get before {
    return Intl.message(
      'before',
      name: 'before',
      desc: '',
      args: [],
    );
  }

  /// `days`
  String get days {
    return Intl.message(
      'days',
      name: 'days',
      desc: '',
      args: [],
    );
  }

  /// `Days`
  String get days_capital {
    return Intl.message(
      'Days',
      name: 'days_capital',
      desc: '',
      args: [],
    );
  }

  /// `day`
  String get day {
    return Intl.message(
      'day',
      name: 'day',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to the`
  String get welcome_to_the {
    return Intl.message(
      'Welcome to the',
      name: 'welcome_to_the',
      desc: '',
      args: [],
    );
  }

  /// `family`
  String get family {
    return Intl.message(
      'family',
      name: 'family',
      desc: '',
      args: [],
    );
  }

  /// `Verify`
  String get verify {
    return Intl.message(
      'Verify',
      name: 'verify',
      desc: '',
      args: [],
    );
  }

  /// `Code`
  String get code {
    return Intl.message(
      'Code',
      name: 'code',
      desc: '',
      args: [],
    );
  }

  /// `Resend`
  String get resend {
    return Intl.message(
      'Resend',
      name: 'resend',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get user_name {
    return Intl.message(
      'Username',
      name: 'user_name',
      desc: '',
      args: [],
    );
  }

  /// `GolCoin`
  String get gol_coin {
    return Intl.message(
      'GolCoin',
      name: 'gol_coin',
      desc: '',
      args: [],
    );
  }

  /// `password is empty\n`
  String get password_is_empty {
    return Intl.message(
      'password is empty\n',
      name: 'password_is_empty',
      desc: '',
      args: [],
    );
  }

  /// `password should contain at least 8 charachters\n`
  String get password_should_contain_at_least_8_charachters {
    return Intl.message(
      'password should contain at least 8 charachters\n',
      name: 'password_should_contain_at_least_8_charachters',
      desc: '',
      args: [],
    );
  }

  /// `password should contain at least one lowercase letter\n`
  String get password_should_contain_at_least_one_lowercase_letter {
    return Intl.message(
      'password should contain at least one lowercase letter\n',
      name: 'password_should_contain_at_least_one_lowercase_letter',
      desc: '',
      args: [],
    );
  }

  /// `password should contain at least one upercase letter\n`
  String get password_should_contain_at_least_one_upercase_letter {
    return Intl.message(
      'password should contain at least one upercase letter\n',
      name: 'password_should_contain_at_least_one_upercase_letter',
      desc: '',
      args: [],
    );
  }

  /// `password should contain at least one number\n`
  String get password_should_contain_at_least_one_number {
    return Intl.message(
      'password should contain at least one number\n',
      name: 'password_should_contain_at_least_one_number',
      desc: '',
      args: [],
    );
  }

  /// `password should contain at least one Symbol\n`
  String get password_should_contain_at_least_one_symobol {
    return Intl.message(
      'password should contain at least one Symbol\n',
      name: 'password_should_contain_at_least_one_symobol',
      desc: '',
      args: [],
    );
  }

  /// `Your account has been activated`
  String get account_activated {
    return Intl.message(
      'Your account has been activated',
      name: 'account_activated',
      desc: '',
      args: [],
    );
  }

  /// `Your account has not been activated`
  String get account_not_activated {
    return Intl.message(
      'Your account has not been activated',
      name: 'account_not_activated',
      desc: '',
      args: [],
    );
  }

  /// `A verification link has been sent to your email`
  String get verification_sent_email {
    return Intl.message(
      'A verification link has been sent to your email',
      name: 'verification_sent_email',
      desc: '',
      args: [],
    );
  }

  /// `Password changed successfully`
  String get password_changed_successfully {
    return Intl.message(
      'Password changed successfully',
      name: 'password_changed_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Logout successfully`
  String get logout_successfully {
    return Intl.message(
      'Logout successfully',
      name: 'logout_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Hi, `
  String get hi {
    return Intl.message(
      'Hi, ',
      name: 'hi',
      desc: '',
      args: [],
    );
  }

  /// `after`
  String get after {
    return Intl.message(
      'after',
      name: 'after',
      desc: '',
      args: [],
    );
  }

  /// `You have earned`
  String get you_have_earned {
    return Intl.message(
      'You have earned',
      name: 'you_have_earned',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred, please try again`
  String get error_occurred {
    return Intl.message(
      'An error occurred, please try again',
      name: 'error_occurred',
      desc: '',
      args: [],
    );
  }

  /// `Discount`
  String get discount {
    return Intl.message(
      'Discount',
      name: 'discount',
      desc: '',
      args: [],
    );
  }

  /// `Delete account`
  String get delete_account {
    return Intl.message(
      'Delete account',
      name: 'delete_account',
      desc: '',
      args: [],
    );
  }

  /// `Deduct`
  String get deduct {
    return Intl.message(
      'Deduct',
      name: 'deduct',
      desc: '',
      args: [],
    );
  }

  /// `Camera`
  String get camera {
    return Intl.message(
      'Camera',
      name: 'camera',
      desc: '',
      args: [],
    );
  }

  /// `Gallery`
  String get gallery {
    return Intl.message(
      'Gallery',
      name: 'gallery',
      desc: '',
      args: [],
    );
  }

  /// `Full name`
  String get full_name {
    return Intl.message(
      'Full name',
      name: 'full_name',
      desc: '',
      args: [],
    );
  }

  /// `Please fill in all required fields`
  String get please_fill_fields {
    return Intl.message(
      'Please fill in all required fields',
      name: 'please_fill_fields',
      desc: '',
      args: [],
    );
  }

  /// `Date of Birth`
  String get birthdate {
    return Intl.message(
      'Date of Birth',
      name: 'birthdate',
      desc: '',
      args: [],
    );
  }

  /// `Your application will be reviewed`
  String get application_reviewed {
    return Intl.message(
      'Your application will be reviewed',
      name: 'application_reviewed',
      desc: '',
      args: [],
    );
  }

  /// `Pending`
  String get pending {
    return Intl.message(
      'Pending',
      name: 'pending',
      desc: '',
      args: [],
    );
  }

  /// `Note`
  String get note {
    return Intl.message(
      'Note',
      name: 'note',
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
      Locale.fromSubtags(languageCode: 'ar'),
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
