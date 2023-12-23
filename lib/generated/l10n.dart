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

  /// `NEED FACILITIES`
  String get needFacilities {
    return Intl.message(
      'NEED FACILITIES',
      name: 'needFacilities',
      desc: '',
      args: [],
    );
  }

  /// `Technicians at doorstep`
  String get techniciansAtDoorstep {
    return Intl.message(
      'Technicians at doorstep',
      name: 'techniciansAtDoorstep',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get username {
    return Intl.message(
      'Username',
      name: 'username',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password`
  String get forgotPassword {
    return Intl.message(
      'Forgot Password',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get signIn {
    return Intl.message(
      'Sign In',
      name: 'signIn',
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

  /// `Register`
  String get register {
    return Intl.message(
      'Register',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
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

  /// `Country`
  String get country {
    return Intl.message(
      'Country',
      name: 'country',
      desc: '',
      args: [],
    );
  }

  /// `Contact No`
  String get contactNo {
    return Intl.message(
      'Contact No',
      name: 'contactNo',
      desc: '',
      args: [],
    );
  }

  /// `is not valid`
  String get isNotValid {
    return Intl.message(
      'is not valid',
      name: 'isNotValid',
      desc: '',
      args: [],
    );
  }

  /// `Reset`
  String get reset {
    return Intl.message(
      'Reset',
      name: 'reset',
      desc: '',
      args: [],
    );
  }

  /// `Reset Email  sent`
  String get resetEmailSent {
    return Intl.message(
      'Reset Email  sent',
      name: 'resetEmailSent',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Show Profile`
  String get showProfile {
    return Intl.message(
      'Show Profile',
      name: 'showProfile',
      desc: '',
      args: [],
    );
  }

  /// `Latest Offers`
  String get latestOffers {
    return Intl.message(
      'Latest Offers',
      name: 'latestOffers',
      desc: '',
      args: [],
    );
  }

  /// `Latest Booking`
  String get latestBooking {
    return Intl.message(
      'Latest Booking',
      name: 'latestBooking',
      desc: '',
      args: [],
    );
  }

  /// `Booking Id`
  String get bookingId {
    return Intl.message(
      'Booking Id',
      name: 'bookingId',
      desc: '',
      args: [],
    );
  }

  /// `Booking Data`
  String get bookingData {
    return Intl.message(
      'Booking Data',
      name: 'bookingData',
      desc: '',
      args: [],
    );
  }

  /// `Booking Notes`
  String get bookingNotes {
    return Intl.message(
      'Booking Notes',
      name: 'bookingNotes',
      desc: '',
      args: [],
    );
  }

  /// `Booking location`
  String get bookingLocation {
    return Intl.message(
      'Booking location',
      name: 'bookingLocation',
      desc: '',
      args: [],
    );
  }

  /// `Services`
  String get services {
    return Intl.message(
      'Services',
      name: 'services',
      desc: '',
      args: [],
    );
  }

  /// `What you want?`
  String get whatYouWant {
    return Intl.message(
      'What you want?',
      name: 'whatYouWant',
      desc: '',
      args: [],
    );
  }

  /// `Choose your service`
  String get chooseYourService {
    return Intl.message(
      'Choose your service',
      name: 'chooseYourService',
      desc: '',
      args: [],
    );
  }

  /// `Sub Services`
  String get subServices {
    return Intl.message(
      'Sub Services',
      name: 'subServices',
      desc: '',
      args: [],
    );
  }

  /// `Choose Category`
  String get chooseCategory {
    return Intl.message(
      'Choose Category',
      name: 'chooseCategory',
      desc: '',
      args: [],
    );
  }

  /// `Book`
  String get book {
    return Intl.message(
      'Book',
      name: 'book',
      desc: '',
      args: [],
    );
  }

  /// `Book Notes`
  String get bookNotes {
    return Intl.message(
      'Book Notes',
      name: 'bookNotes',
      desc: '',
      args: [],
    );
  }

  /// `Book Service`
  String get bookService {
    return Intl.message(
      'Book Service',
      name: 'bookService',
      desc: '',
      args: [],
    );
  }

  /// `Select Date`
  String get selectDate {
    return Intl.message(
      'Select Date',
      name: 'selectDate',
      desc: '',
      args: [],
    );
  }

  /// `Select you location!`
  String get selectYouLocation {
    return Intl.message(
      'Select you location!',
      name: 'selectYouLocation',
      desc: '',
      args: [],
    );
  }

  /// `Book Summery`
  String get bookSummery {
    return Intl.message(
      'Book Summery',
      name: 'bookSummery',
      desc: '',
      args: [],
    );
  }

  /// `Call or Whatsapp`
  String get callOrWhatsapp {
    return Intl.message(
      'Call or Whatsapp',
      name: 'callOrWhatsapp',
      desc: '',
      args: [],
    );
  }

  /// `info@need.ae`
  String get infoneedae {
    return Intl.message(
      'info@need.ae',
      name: 'infoneedae',
      desc: '',
      args: [],
    );
  }

  /// `If you need more details`
  String get ifYouNeedMoreDetails {
    return Intl.message(
      'If you need more details',
      name: 'ifYouNeedMoreDetails',
      desc: '',
      args: [],
    );
  }

  /// `Thanks for booking service with our team will contact you soon`
  String get thanksForBookingService {
    return Intl.message(
      'Thanks for booking service with our team will contact you soon',
      name: 'thanksForBookingService',
      desc: '',
      args: [],
    );
  }

  /// `Select Time`
  String get selectTime {
    return Intl.message(
      'Select Time',
      name: 'selectTime',
      desc: '',
      args: [],
    );
  }

  /// `Book More`
  String get bookMore {
    return Intl.message(
      'Book More',
      name: 'bookMore',
      desc: '',
      args: [],
    );
  }

  /// `My Booking`
  String get myBooking {
    return Intl.message(
      'My Booking',
      name: 'myBooking',
      desc: '',
      args: [],
    );
  }

  /// `Booking Time`
  String get bookingTime {
    return Intl.message(
      'Booking Time',
      name: 'bookingTime',
      desc: '',
      args: [],
    );
  }

  /// `Booking Status`
  String get bookingStatus {
    return Intl.message(
      'Booking Status',
      name: 'bookingStatus',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Select Payment Way`
  String get selectPaymentWay {
    return Intl.message(
      'Select Payment Way',
      name: 'selectPaymentWay',
      desc: '',
      args: [],
    );
  }

  /// `Proceed`
  String get proceed {
    return Intl.message(
      'Proceed',
      name: 'proceed',
      desc: '',
      args: [],
    );
  }

  /// `Card`
  String get card {
    return Intl.message(
      'Card',
      name: 'card',
      desc: '',
      args: [],
    );
  }

  /// `Payment Link`
  String get paymentLink {
    return Intl.message(
      'Payment Link',
      name: 'paymentLink',
      desc: '',
      args: [],
    );
  }

  /// `Cash On Delivery`
  String get cashOnDelivery {
    return Intl.message(
      'Cash On Delivery',
      name: 'cashOnDelivery',
      desc: '',
      args: [],
    );
  }

  /// `Payment Status`
  String get paymentStatus {
    return Intl.message(
      'Payment Status',
      name: 'paymentStatus',
      desc: '',
      args: [],
    );
  }

  /// `Book More Services`
  String get bookMoreServices {
    return Intl.message(
      'Book More Services',
      name: 'bookMoreServices',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get update {
    return Intl.message(
      'Update',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `Update Password`
  String get updatePassword {
    return Intl.message(
      'Update Password',
      name: 'updatePassword',
      desc: '',
      args: [],
    );
  }

  /// `Current Password`
  String get currentPassword {
    return Intl.message(
      'Current Password',
      name: 'currentPassword',
      desc: '',
      args: [],
    );
  }

  /// `Something error`
  String get somethingError {
    return Intl.message(
      'Something error',
      name: 'somethingError',
      desc: '',
      args: [],
    );
  }

  /// `No Data Fount`
  String get noDataFount {
    return Intl.message(
      'No Data Fount',
      name: 'noDataFount',
      desc: '',
      args: [],
    );
  }

  /// `Pleas Add required field`
  String get pleasAddRequiredField {
    return Intl.message(
      'Pleas Add required field',
      name: 'pleasAddRequiredField',
      desc: '',
      args: [],
    );
  }

  /// `This field required`
  String get thisFieldRequired {
    return Intl.message(
      'This field required',
      name: 'thisFieldRequired',
      desc: '',
      args: [],
    );
  }

  /// `Successful response`
  String get successfulResponse {
    return Intl.message(
      'Successful response',
      name: 'successfulResponse',
      desc: '',
      args: [],
    );
  }

  /// `Operation Failed`
  String get operationFailed {
    return Intl.message(
      'Operation Failed',
      name: 'operationFailed',
      desc: '',
      args: [],
    );
  }

  /// `Password and confirm password are mismatch`
  String get passwordAndConfirmMismatch {
    return Intl.message(
      'Password and confirm password are mismatch',
      name: 'passwordAndConfirmMismatch',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message(
      'Done',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `Press on edit button`
  String get pressOnEditButton {
    return Intl.message(
      'Press on edit button',
      name: 'pressOnEditButton',
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
