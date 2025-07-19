import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_am.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
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
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('am'),
    Locale('en'),
    Locale('es')
  ];

  /// No description provided for @hello.
  ///
  /// In en, this message translates to:
  /// **'Akkam Bultee'**
  String get hello;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Baga Gara Abbaa Taayitaa H---------nsa Magaalaa Finfinneetti Waajjira Damee NifasSilk Laaftoo dhuftan'**
  String get welcome;

  /// No description provided for @services.
  ///
  /// In en, this message translates to:
  /// **'Tajaajiloota'**
  String get services;

  /// No description provided for @service_description.
  ///
  /// In en, this message translates to:
  /// **'Waa’ee tajaajila dhaabbaticha keessatti kennamuu fi kutaa tajaajilli itti kennamu, akkasumas tajaajilicha argachuuf maal isinirraa  akka eegamu  sin hubachiisa.'**
  String get service_description;

  /// No description provided for @direction.
  ///
  /// In en, this message translates to:
  /// **'Eessa deemuu barbaaddan'**
  String get direction;

  /// No description provided for @direction_description.
  ///
  /// In en, this message translates to:
  /// **'Kutaa hojii ykn ogeeyyii fi hoggantoota dhaabbaticha biiroo jiran akka beektan sin dandeessisa'**
  String get direction_description;

  /// No description provided for @comment_company.
  ///
  /// In en, this message translates to:
  /// **'Yaada Keennuu'**
  String get comment_company;

  /// No description provided for @comment_description.
  ///
  /// In en, this message translates to:
  /// **'Tajaajila dhaabbaticha keessatti kennamu irratti komii yoo qabaattan, kana fayyadamuun komii keessan ibsaa'**
  String get comment_description;

  /// No description provided for @rate.
  ///
  /// In en, this message translates to:
  /// **'Safarati Tajaajila'**
  String get rate;

  /// No description provided for @rate_description.
  ///
  /// In en, this message translates to:
  /// **'Kenniinsa tajaajilaa fi keessummeessitoota dhaabbatichaa irratti itti quufinsa qabdan ibsaa'**
  String get rate_description;

  /// No description provided for @driver_services.
  ///
  /// In en, this message translates to:
  /// **'Tajaajila konkolaachisaa'**
  String get driver_services;

  /// No description provided for @vehicle_services.
  ///
  /// In en, this message translates to:
  /// **'Tajaajila konkolaataa'**
  String get vehicle_services;

  /// No description provided for @time_it_takes.
  ///
  /// In en, this message translates to:
  /// **'yeroon fudhatu'**
  String get time_it_takes;

  /// No description provided for @minute.
  ///
  /// In en, this message translates to:
  /// **'Daqiqaa'**
  String get minute;

  /// No description provided for @requirement_to_get_service.
  ///
  /// In en, this message translates to:
  /// **'Haala maamiltichi tajaajila argachuuf dursa guutachu qabu'**
  String get requirement_to_get_service;

  /// No description provided for @office_name.
  ///
  /// In en, this message translates to:
  /// **'Bulchiinsa Magaalaa Finfinneetti Taayitaa Hayyama fi To\'annoo Konkolaachisaa fi Konkolaataa Waajjira Damee NifasSilk Laaftoo'**
  String get office_name;

  /// No description provided for @service_rate_title.
  ///
  /// In en, this message translates to:
  /// **'Tajaajila Waajjirri kennu irratti yaada Maamiltootaa Fudhachuuf CheckListii Qophaa\'e'**
  String get service_rate_title;

  /// No description provided for @full_name.
  ///
  /// In en, this message translates to:
  /// **'Maqaa guutuu koomii dhiyeessaa'**
  String get full_name;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Maqaa'**
  String get name;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Teessoo'**
  String get address;

  /// No description provided for @city.
  ///
  /// In en, this message translates to:
  /// **'Magaalaa'**
  String get city;

  /// No description provided for @sub_city.
  ///
  /// In en, this message translates to:
  /// **'K/Magaalaa'**
  String get sub_city;

  /// No description provided for @woreda.
  ///
  /// In en, this message translates to:
  /// **'Waradaa'**
  String get woreda;

  /// No description provided for @home_no.
  ///
  /// In en, this message translates to:
  /// **'Lakk. Manaa'**
  String get home_no;

  /// No description provided for @phone_number.
  ///
  /// In en, this message translates to:
  /// **'Lakk. Bilibilaa'**
  String get phone_number;

  /// No description provided for @compliment_reason.
  ///
  /// In en, this message translates to:
  /// **'Dhimma ijoo himannichaa gabaabinaan ibsi'**
  String get compliment_reason;

  /// No description provided for @reason_date.
  ///
  /// In en, this message translates to:
  /// **'Guyyaa gochi isa sababa ta’e itti raawwatame'**
  String get reason_date;

  /// No description provided for @place.
  ///
  /// In en, this message translates to:
  /// **'Bakkaa/Waajjira'**
  String get place;

  /// No description provided for @case_team.
  ///
  /// In en, this message translates to:
  /// **'Garee Adeemsa hojii xiqqaa dhimmichi ilaallatu'**
  String get case_team;

  /// No description provided for @case_employee.
  ///
  /// In en, this message translates to:
  /// **'Maqaa tajaajila kennuu dhimmi ilaallatu'**
  String get case_employee;

  /// No description provided for @supporting_data.
  ///
  /// In en, this message translates to:
  /// **'Ragaan bal’aan deeggaru yoo jiraate'**
  String get supporting_data;

  /// No description provided for @complilmenter_need.
  ///
  /// In en, this message translates to:
  /// **'Dhimmichi maal akka hojjetamu ykn akka hojjetamu barbaadu gabaabinaan ibsi'**
  String get complilmenter_need;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Guyyaa'**
  String get date;

  /// No description provided for @reminder.
  ///
  /// In en, this message translates to:
  /// **'Yaadachiisaa '**
  String get reminder;

  /// No description provided for @reminder1.
  ///
  /// In en, this message translates to:
  /// **'Dhimmi komii kanaa qindeessaa/hogganaa adeemsaa  dhimmi ilaallatuun kan murtaa’u ta’a.'**
  String get reminder1;

  /// No description provided for @reminder2.
  ///
  /// In en, this message translates to:
  /// **'Himatamaan unka kana guutuu isaa dura hojjattoota tajaajila kennaniif dhimmicha ibsee deebii argachuu isaa mirkaneeffachuu qaba. Deebii kennameef yoo hin quufne unka kana guutee komii adeemsa hojii/hogganaa hojii xiqqaa/qindeessaa dhimmi ilaallatuuf dhiyeessu qaba.'**
  String get reminder2;

  /// No description provided for @reminder3.
  ///
  /// In en, this message translates to:
  /// **'Qindeessaan adeemsa hojii komii dhimmi ilaallatu dhimmicha qoratee unka dhimma kanaaf qophaa’e irratti murtii ni kenna, himanni erga dhiyaatee guyyoota hojii 3 walitti aansuun keessatti himatamaa barreeffamaan ni beeksisa.'**
  String get reminder3;

  /// No description provided for @reminder4.
  ///
  /// In en, this message translates to:
  /// **'Himatamaan murtii kennametti kan hin quufne yoo ta’e, sana booda Qaama/Koree Dhaddacha Komii fi Ol’iyyannootti iyyachuu ni danda’a.'**
  String get reminder4;

  /// No description provided for @reminder5.
  ///
  /// In en, this message translates to:
  /// **'Dhimmi komii kanaa adeemsa/hogganaa adeemsa xiqqaa/qindeessaa dhimmi ilaallatuun kan murtaa’u ta’a.'**
  String get reminder5;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Galchi'**
  String get submit;

  /// No description provided for @compilment_title.
  ///
  /// In en, this message translates to:
  /// **'Unka komii dhiyeessuun Abbaa Dhimmootaa -001'**
  String get compilment_title;

  /// No description provided for @agree.
  ///
  /// In en, this message translates to:
  /// **'Unka kana akkan guute walii gala'**
  String get agree;

  /// No description provided for @select_local.
  ///
  /// In en, this message translates to:
  /// **'Afaan Filadhaa'**
  String get select_local;

  /// No description provided for @office.
  ///
  /// In en, this message translates to:
  /// **'Lakk. Foddaa '**
  String get office;

  /// No description provided for @select_an_office.
  ///
  /// In en, this message translates to:
  /// **'Biiroo ittin tajaajila fudhatan fildadha'**
  String get select_an_office;

  /// No description provided for @form_sumbitted.
  ///
  /// In en, this message translates to:
  /// **'Unkaan Milkaa\'inaan Ergameera !'**
  String get form_sumbitted;

  /// No description provided for @rate_overall_service.
  ///
  /// In en, this message translates to:
  /// **'Tajaajilli dhaabbaticha keessatti argattan akkam ture? Yaada keessan nuuf kennaa.'**
  String get rate_overall_service;

  /// No description provided for @feed_back_form.
  ///
  /// In en, this message translates to:
  /// **'Yaada Galchuu'**
  String get feed_back_form;

  /// No description provided for @feed_back_form_description.
  ///
  /// In en, this message translates to:
  /// **'yaadni keessan tajaajila keenya fooyyessuu fi muuxannoo fooyya\'aa nama hundaaf uumuuf nu gargaara. Hubannoo fi yaada keessaniif iddoo guddaa kennina.'**
  String get feed_back_form_description;

  /// No description provided for @comment.
  ///
  /// In en, this message translates to:
  /// **'Koomii kennuu'**
  String get comment;

  /// No description provided for @comments.
  ///
  /// In en, this message translates to:
  /// **'Yaada Keennu'**
  String get comments;

  /// No description provided for @suggestion.
  ///
  /// In en, this message translates to:
  /// **'Yaada Dhiheessu'**
  String get suggestion;

  /// No description provided for @question.
  ///
  /// In en, this message translates to:
  /// **'Gaaffii'**
  String get question;

  /// No description provided for @your_feed_back.
  ///
  /// In en, this message translates to:
  /// **'Yaada keessan'**
  String get your_feed_back;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Imeli'**
  String get email;

  /// No description provided for @submit_feed_back.
  ///
  /// In en, this message translates to:
  /// **'Yaada kenni'**
  String get submit_feed_back;

  /// No description provided for @feed_back_type.
  ///
  /// In en, this message translates to:
  /// **'Goosa Koomii keennamu'**
  String get feed_back_type;

  /// No description provided for @choose_feed_back_audio.
  ///
  /// In en, this message translates to:
  /// **'Yaada keessan sagaleedhaan kennuu barbaannaan kana tuuqa'**
  String get choose_feed_back_audio;

  /// No description provided for @are_you_sure.
  ///
  /// In en, this message translates to:
  /// **'Sagalee Waraabdan erguuf mirkaneeffatanii '**
  String get are_you_sure;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'Eyyee'**
  String get ok;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'Dhiisi'**
  String get no;

  /// No description provided for @top_rated_tile.
  ///
  /// In en, this message translates to:
  /// **'Ga\'umsa'**
  String get top_rated_tile;

  /// No description provided for @top_rated_description.
  ///
  /// In en, this message translates to:
  /// **'Hojjettoota Qabxii Maamiltootaan Keennameen Sadarkaa Ol\'aanaa Argatan'**
  String get top_rated_description;

  /// No description provided for @position.
  ///
  /// In en, this message translates to:
  /// **'Gita hojii'**
  String get position;

  /// No description provided for @point.
  ///
  /// In en, this message translates to:
  /// **'Qabxii Giddugaleessaa'**
  String get point;

  /// No description provided for @team_members.
  ///
  /// In en, this message translates to:
  /// **'Miseensota isa/ishii jala jiran >>'**
  String get team_members;

  /// No description provided for @group_members.
  ///
  /// In en, this message translates to:
  /// **'Gareewwan isa/ishii jala jiran >>'**
  String get group_members;

  /// No description provided for @audio_description.
  ///
  /// In en, this message translates to:
  /// **'Yaada sagalee kennuudhaaf,Jalqaba maqaa keessan guutuu fi lakkoofsa bilbilaa sirrii ta\'e galchaa,sana booda sagalee keessan waraabuuf cuqaasaa, yeroo xumurtan deebitanii mallattoo dhaabuu tuquun  yaada keessan galchaa.'**
  String get audio_description;

  /// No description provided for @burueu.
  ///
  /// In en, this message translates to:
  /// **'Lakk. Biiroo'**
  String get burueu;

  /// No description provided for @environmental_pollution_control.
  ///
  /// In en, this message translates to:
  /// **'Environmental pollution control'**
  String get environmental_pollution_control;

  /// No description provided for @climate_change_and_alternative_energy_technology_dissemination_and_awareness.
  ///
  /// In en, this message translates to:
  /// **'Climate Change and Alternative Energy Technology Dissemination and Awareness'**
  String get climate_change_and_alternative_energy_technology_dissemination_and_awareness;

  /// No description provided for @mineral_resource_research_Licensing_and_management.
  ///
  /// In en, this message translates to:
  /// **'Mineral Resource Research, Licensing, and Management'**
  String get mineral_resource_research_Licensing_and_management;

  /// No description provided for @biodiversity_and_ecosystem_management.
  ///
  /// In en, this message translates to:
  /// **'Biodiversity and Ecosystem Management'**
  String get biodiversity_and_ecosystem_management;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['am', 'en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'am': return AppLocalizationsAm();
    case 'en': return AppLocalizationsEn();
    case 'es': return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
