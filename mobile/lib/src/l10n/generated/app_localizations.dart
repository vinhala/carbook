import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_it.dart';
import 'app_localizations_pl.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
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
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('it'),
    Locale('pl'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Carful'**
  String get appTitle;

  /// No description provided for @addCar.
  ///
  /// In en, this message translates to:
  /// **'Add car'**
  String get addCar;

  /// No description provided for @unableToLoadGarage.
  ///
  /// In en, this message translates to:
  /// **'Unable to load your garage.\n{error}'**
  String unableToLoadGarage(Object error);

  /// No description provided for @garageEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Your garage is ready'**
  String get garageEmptyTitle;

  /// No description provided for @garageEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Create your first car profile to start tracking mileage and reminders.'**
  String get garageEmptyBody;

  /// No description provided for @createFirstProfile.
  ///
  /// In en, this message translates to:
  /// **'Create your first profile'**
  String get createFirstProfile;

  /// No description provided for @invalidCarProfile.
  ///
  /// In en, this message translates to:
  /// **'Invalid car profile.'**
  String get invalidCarProfile;

  /// No description provided for @carProfileNotFound.
  ///
  /// In en, this message translates to:
  /// **'This car profile could not be found.'**
  String get carProfileNotFound;

  /// No description provided for @unableToLoadProfile.
  ///
  /// In en, this message translates to:
  /// **'Unable to load the profile.\n{error}'**
  String unableToLoadProfile(Object error);

  /// No description provided for @unableToLoadCarProfile.
  ///
  /// In en, this message translates to:
  /// **'Unable to load the car profile.\n{error}'**
  String unableToLoadCarProfile(Object error);

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @addNewCar.
  ///
  /// In en, this message translates to:
  /// **'Add New Car'**
  String get addNewCar;

  /// No description provided for @backToGarage.
  ///
  /// In en, this message translates to:
  /// **'Back to garage'**
  String get backToGarage;

  /// No description provided for @tapToAddCarPhoto.
  ///
  /// In en, this message translates to:
  /// **'Tap to add a car photo'**
  String get tapToAddCarPhoto;

  /// No description provided for @make.
  ///
  /// In en, this message translates to:
  /// **'Make'**
  String get make;

  /// No description provided for @model.
  ///
  /// In en, this message translates to:
  /// **'Model'**
  String get model;

  /// No description provided for @engine.
  ///
  /// In en, this message translates to:
  /// **'Engine'**
  String get engine;

  /// No description provided for @vin.
  ///
  /// In en, this message translates to:
  /// **'VIN'**
  String get vin;

  /// No description provided for @firstRegistration.
  ///
  /// In en, this message translates to:
  /// **'First registration'**
  String get firstRegistration;

  /// No description provided for @miles.
  ///
  /// In en, this message translates to:
  /// **'Miles'**
  String get miles;

  /// No description provided for @kilometers.
  ///
  /// In en, this message translates to:
  /// **'Kilometers'**
  String get kilometers;

  /// No description provided for @currentMileage.
  ///
  /// In en, this message translates to:
  /// **'Current mileage'**
  String get currentMileage;

  /// No description provided for @mileageReminders.
  ///
  /// In en, this message translates to:
  /// **'Mileage reminders'**
  String get mileageReminders;

  /// No description provided for @mileageReminderHelp.
  ///
  /// In en, this message translates to:
  /// **'Choose how often Carful should remind you to update mileage for this car.'**
  String get mileageReminderHelp;

  /// No description provided for @reminderOffWarning.
  ///
  /// In en, this message translates to:
  /// **'Turning reminders off can make it easier to miss critical maintenance intervals.'**
  String get reminderOffWarning;

  /// No description provided for @quarterlyReminderWarning.
  ///
  /// In en, this message translates to:
  /// **'Quarterly reminders can be too sparse for cars that need close attention.'**
  String get quarterlyReminderWarning;

  /// No description provided for @saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get saveChanges;

  /// No description provided for @createProfile.
  ///
  /// In en, this message translates to:
  /// **'Create Profile'**
  String get createProfile;

  /// No description provided for @deleteProfile.
  ///
  /// In en, this message translates to:
  /// **'Delete Profile'**
  String get deleteProfile;

  /// No description provided for @fieldRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required.'**
  String get fieldRequired;

  /// No description provided for @mileageRequired.
  ///
  /// In en, this message translates to:
  /// **'Mileage is required.'**
  String get mileageRequired;

  /// No description provided for @mileagePositiveWholeNumber.
  ///
  /// In en, this message translates to:
  /// **'Mileage must be a positive whole number.'**
  String get mileagePositiveWholeNumber;

  /// No description provided for @selectFirstRegistrationMonth.
  ///
  /// In en, this message translates to:
  /// **'Select first registration month'**
  String get selectFirstRegistrationMonth;

  /// No description provided for @unableToSaveCarProfile.
  ///
  /// In en, this message translates to:
  /// **'Unable to save this car profile.\n{error}'**
  String unableToSaveCarProfile(Object error);

  /// No description provided for @deleteProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete this profile?'**
  String get deleteProfileTitle;

  /// No description provided for @deleteProfileBody.
  ///
  /// In en, this message translates to:
  /// **'This removes the car profile and its mileage reminder schedule. This cannot be undone.'**
  String get deleteProfileBody;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @unableToDeleteProfile.
  ///
  /// In en, this message translates to:
  /// **'Unable to delete this profile.\n{error}'**
  String unableToDeleteProfile(Object error);

  /// No description provided for @registeredDate.
  ///
  /// In en, this message translates to:
  /// **'Registered {date}'**
  String registeredDate(Object date);

  /// No description provided for @mileage.
  ///
  /// In en, this message translates to:
  /// **'Mileage'**
  String get mileage;

  /// No description provided for @updateMileage.
  ///
  /// In en, this message translates to:
  /// **'Update mileage'**
  String get updateMileage;

  /// No description provided for @lastUpdatedOn.
  ///
  /// In en, this message translates to:
  /// **'Last updated on {date}'**
  String lastUpdatedOn(Object date);

  /// No description provided for @vehicleDetails.
  ///
  /// In en, this message translates to:
  /// **'Vehicle details'**
  String get vehicleDetails;

  /// No description provided for @mileageReminder.
  ///
  /// In en, this message translates to:
  /// **'Mileage reminder'**
  String get mileageReminder;

  /// No description provided for @mileageReminderWarningBody.
  ///
  /// In en, this message translates to:
  /// **'This cadence can make it easier to miss critical maintenance intervals.'**
  String get mileageReminderWarningBody;

  /// No description provided for @mileageReminderNudgeBody.
  ///
  /// In en, this message translates to:
  /// **'Carful will keep nudging you to keep mileage fresh for future maintenance tracking.'**
  String get mileageReminderNudgeBody;

  /// No description provided for @maintenanceSchedule.
  ///
  /// In en, this message translates to:
  /// **'Maintenance schedule'**
  String get maintenanceSchedule;

  /// No description provided for @open.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get open;

  /// No description provided for @maintenanceScheduleCardBody.
  ///
  /// In en, this message translates to:
  /// **'Track recurring maintenance, see what is overdue, and log completed service from one place.'**
  String get maintenanceScheduleCardBody;

  /// No description provided for @maintenanceScheduleCardHint.
  ///
  /// In en, this message translates to:
  /// **'Create mileage- or time-based items for this vehicle.'**
  String get maintenanceScheduleCardHint;

  /// No description provided for @repairsModifications.
  ///
  /// In en, this message translates to:
  /// **'Repairs & modifications'**
  String get repairsModifications;

  /// No description provided for @repairsModificationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Repairs & Modifications'**
  String get repairsModificationsTitle;

  /// No description provided for @repairsModificationsBody.
  ///
  /// In en, this message translates to:
  /// **'Keep planned repairs, completed fixes, and upgrades together so you always know what is next.'**
  String get repairsModificationsBody;

  /// No description provided for @plannedRepairCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 planned repair} other{{count} planned repairs}}'**
  String plannedRepairCount(int count);

  /// No description provided for @loadingPlannedRepairs.
  ///
  /// In en, this message translates to:
  /// **'Loading planned repairs...'**
  String get loadingPlannedRepairs;

  /// No description provided for @unableToLoadPlannedRepairs.
  ///
  /// In en, this message translates to:
  /// **'Unable to load planned repairs.'**
  String get unableToLoadPlannedRepairs;

  /// No description provided for @workshopManuals.
  ///
  /// In en, this message translates to:
  /// **'Workshop manuals'**
  String get workshopManuals;

  /// No description provided for @adding.
  ///
  /// In en, this message translates to:
  /// **'Adding...'**
  String get adding;

  /// No description provided for @addManual.
  ///
  /// In en, this message translates to:
  /// **'Add manual'**
  String get addManual;

  /// No description provided for @loadingManuals.
  ///
  /// In en, this message translates to:
  /// **'Loading manuals...'**
  String get loadingManuals;

  /// No description provided for @unableToLoadManuals.
  ///
  /// In en, this message translates to:
  /// **'Unable to load manuals.\n{error}'**
  String unableToLoadManuals(Object error);

  /// No description provided for @addPdfManuals.
  ///
  /// In en, this message translates to:
  /// **'Add PDF workshop manuals so Carful AI can answer questions about this vehicle and generate schedule suggestions.'**
  String get addPdfManuals;

  /// No description provided for @aiAssistant.
  ///
  /// In en, this message translates to:
  /// **'AI Assistant'**
  String get aiAssistant;

  /// No description provided for @aiAssistantReadyBody.
  ///
  /// In en, this message translates to:
  /// **'Use your manuals, maintenance history, and repair context to answer vehicle-specific questions.'**
  String get aiAssistantReadyBody;

  /// No description provided for @aiAssistantNeedsManual.
  ///
  /// In en, this message translates to:
  /// **'Add at least one workshop manual to start using the assistant.'**
  String get aiAssistantNeedsManual;

  /// No description provided for @enterValidMileage.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid mileage.'**
  String get enterValidMileage;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @unableToUpdateMileage.
  ///
  /// In en, this message translates to:
  /// **'Unable to update mileage.\n{error}'**
  String unableToUpdateMileage(Object error);

  /// No description provided for @unableToAddWorkshopManuals.
  ///
  /// In en, this message translates to:
  /// **'Unable to add workshop manuals.\n{error}'**
  String unableToAddWorkshopManuals(Object error);

  /// No description provided for @unableToOpenFile.
  ///
  /// In en, this message translates to:
  /// **'Unable to open {name}.'**
  String unableToOpenFile(Object name);

  /// No description provided for @removeWorkshopManualTitle.
  ///
  /// In en, this message translates to:
  /// **'Remove workshop manual?'**
  String get removeWorkshopManualTitle;

  /// No description provided for @removeWorkshopManualBody.
  ///
  /// In en, this message translates to:
  /// **'Carful will remove {name} from this vehicle and the AI assistant context.'**
  String removeWorkshopManualBody(Object name);

  /// No description provided for @remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove;

  /// No description provided for @unableToRemoveManual.
  ///
  /// In en, this message translates to:
  /// **'Unable to remove manual.\n{error}'**
  String unableToRemoveManual(Object error);

  /// No description provided for @invalidMaintenanceSchedule.
  ///
  /// In en, this message translates to:
  /// **'Invalid maintenance schedule.'**
  String get invalidMaintenanceSchedule;

  /// No description provided for @maintenance.
  ///
  /// In en, this message translates to:
  /// **'Maintenance'**
  String get maintenance;

  /// No description provided for @autoGenerateScheduleAi.
  ///
  /// In en, this message translates to:
  /// **'Auto-generate schedule with AI'**
  String get autoGenerateScheduleAi;

  /// No description provided for @uploadManualsEnableAiSchedule.
  ///
  /// In en, this message translates to:
  /// **'Upload manuals to enable AI schedule generation'**
  String get uploadManualsEnableAiSchedule;

  /// No description provided for @newItem.
  ///
  /// In en, this message translates to:
  /// **'New item'**
  String get newItem;

  /// No description provided for @unableToLoadMaintenanceItems.
  ///
  /// In en, this message translates to:
  /// **'Unable to load maintenance items.\n{error}'**
  String unableToLoadMaintenanceItems(Object error);

  /// No description provided for @noMaintenanceItemsYet.
  ///
  /// In en, this message translates to:
  /// **'No maintenance items yet'**
  String get noMaintenanceItemsYet;

  /// No description provided for @maintenanceEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Create your first recurring maintenance task to start tracking what is due next.'**
  String get maintenanceEmptyBody;

  /// No description provided for @createMaintenanceItem.
  ///
  /// In en, this message translates to:
  /// **'Create maintenance item'**
  String get createMaintenanceItem;

  /// No description provided for @overdue.
  ///
  /// In en, this message translates to:
  /// **'Overdue'**
  String get overdue;

  /// No description provided for @upcoming.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get upcoming;

  /// No description provided for @nextTarget.
  ///
  /// In en, this message translates to:
  /// **'Next target: {target}'**
  String nextTarget(Object target);

  /// No description provided for @nextTargetLabel.
  ///
  /// In en, this message translates to:
  /// **'Next target'**
  String get nextTargetLabel;

  /// No description provided for @log.
  ///
  /// In en, this message translates to:
  /// **'Log'**
  String get log;

  /// No description provided for @invalidMaintenanceItem.
  ///
  /// In en, this message translates to:
  /// **'Invalid maintenance item.'**
  String get invalidMaintenanceItem;

  /// No description provided for @maintenanceItemNotFound.
  ///
  /// In en, this message translates to:
  /// **'This maintenance item could not be found.'**
  String get maintenanceItemNotFound;

  /// No description provided for @unableToLoadMaintenanceItem.
  ///
  /// In en, this message translates to:
  /// **'Unable to load maintenance item.\n{error}'**
  String unableToLoadMaintenanceItem(Object error);

  /// No description provided for @editMaintenanceItem.
  ///
  /// In en, this message translates to:
  /// **'Edit Maintenance Item'**
  String get editMaintenanceItem;

  /// No description provided for @newMaintenanceItem.
  ///
  /// In en, this message translates to:
  /// **'New Maintenance Item'**
  String get newMaintenanceItem;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @oilChangeHint.
  ///
  /// In en, this message translates to:
  /// **'Oil change'**
  String get oilChangeHint;

  /// No description provided for @scheduleConfigurator.
  ///
  /// In en, this message translates to:
  /// **'Schedule Configurator'**
  String get scheduleConfigurator;

  /// No description provided for @distance.
  ///
  /// In en, this message translates to:
  /// **'Distance'**
  String get distance;

  /// No description provided for @time.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get time;

  /// No description provided for @distanceInterval.
  ///
  /// In en, this message translates to:
  /// **'Distance interval'**
  String get distanceInterval;

  /// No description provided for @timeInterval.
  ///
  /// In en, this message translates to:
  /// **'Time interval'**
  String get timeInterval;

  /// No description provided for @timeUnit.
  ///
  /// In en, this message translates to:
  /// **'Time unit'**
  String get timeUnit;

  /// No description provided for @createItem.
  ///
  /// In en, this message translates to:
  /// **'Create Item'**
  String get createItem;

  /// No description provided for @createTimeBasedItem.
  ///
  /// In en, this message translates to:
  /// **'Create Time-Based Item'**
  String get createTimeBasedItem;

  /// No description provided for @deleteMaintenanceItem.
  ///
  /// In en, this message translates to:
  /// **'Delete Maintenance Item'**
  String get deleteMaintenanceItem;

  /// No description provided for @intervalRequired.
  ///
  /// In en, this message translates to:
  /// **'Interval is required.'**
  String get intervalRequired;

  /// No description provided for @enterValidInterval.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid interval.'**
  String get enterValidInterval;

  /// No description provided for @unableToSaveMaintenanceItem.
  ///
  /// In en, this message translates to:
  /// **'Unable to save maintenance item.\n{error}'**
  String unableToSaveMaintenanceItem(Object error);

  /// No description provided for @deleteMaintenanceItemTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete maintenance item?'**
  String get deleteMaintenanceItemTitle;

  /// No description provided for @deleteMaintenanceItemBody.
  ///
  /// In en, this message translates to:
  /// **'This will remove the item and its logged service history.'**
  String get deleteMaintenanceItemBody;

  /// No description provided for @unableToDeleteMaintenanceItem.
  ///
  /// In en, this message translates to:
  /// **'Unable to delete maintenance item.\n{error}'**
  String unableToDeleteMaintenanceItem(Object error);

  /// No description provided for @backToMaintenance.
  ///
  /// In en, this message translates to:
  /// **'Back to maintenance'**
  String get backToMaintenance;

  /// No description provided for @logWork.
  ///
  /// In en, this message translates to:
  /// **'Log work'**
  String get logWork;

  /// No description provided for @unableToLoadMaintenanceDetails.
  ///
  /// In en, this message translates to:
  /// **'Unable to load maintenance details.\n{error}'**
  String unableToLoadMaintenanceDetails(Object error);

  /// No description provided for @nextRequiredWork.
  ///
  /// In en, this message translates to:
  /// **'Next required work'**
  String get nextRequiredWork;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @lastService.
  ///
  /// In en, this message translates to:
  /// **'Last service'**
  String get lastService;

  /// No description provided for @noWorkLoggedYet.
  ///
  /// In en, this message translates to:
  /// **'No work logged yet'**
  String get noWorkLoggedYet;

  /// No description provided for @currentOdometer.
  ///
  /// In en, this message translates to:
  /// **'Current odometer'**
  String get currentOdometer;

  /// No description provided for @serviceHistory.
  ///
  /// In en, this message translates to:
  /// **'Service history'**
  String get serviceHistory;

  /// No description provided for @noPerformedWork.
  ///
  /// In en, this message translates to:
  /// **'No performed work has been logged for this item yet.'**
  String get noPerformedWork;

  /// No description provided for @logPerformedWork.
  ///
  /// In en, this message translates to:
  /// **'Log Performed Work'**
  String get logPerformedWork;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @notes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get notes;

  /// No description provided for @notesHint.
  ///
  /// In en, this message translates to:
  /// **'Optional notes about parts, fluids, or observations'**
  String get notesHint;

  /// No description provided for @unableToLogPerformedWork.
  ///
  /// In en, this message translates to:
  /// **'Unable to log performed work.\n{error}'**
  String unableToLogPerformedWork(Object error);

  /// No description provided for @everyDistance.
  ///
  /// In en, this message translates to:
  /// **'Every {interval} {unit}'**
  String everyDistance(Object interval, Object unit);

  /// No description provided for @everyTime.
  ///
  /// In en, this message translates to:
  /// **'Every {interval}'**
  String everyTime(Object interval);

  /// No description provided for @overdueByDistance.
  ///
  /// In en, this message translates to:
  /// **'Overdue by {distance} {unit}'**
  String overdueByDistance(Object distance, Object unit);

  /// No description provided for @dueNow.
  ///
  /// In en, this message translates to:
  /// **'Due now'**
  String get dueNow;

  /// No description provided for @dueInDistance.
  ///
  /// In en, this message translates to:
  /// **'Due in {distance} {unit}'**
  String dueInDistance(Object distance, Object unit);

  /// No description provided for @overdueByOneDay.
  ///
  /// In en, this message translates to:
  /// **'Overdue by 1 day'**
  String get overdueByOneDay;

  /// No description provided for @overdueByDays.
  ///
  /// In en, this message translates to:
  /// **'Overdue by {days} days'**
  String overdueByDays(int days);

  /// No description provided for @dueToday.
  ///
  /// In en, this message translates to:
  /// **'Due today'**
  String get dueToday;

  /// No description provided for @dueInOneDay.
  ///
  /// In en, this message translates to:
  /// **'Due in 1 day'**
  String get dueInOneDay;

  /// No description provided for @dueInDays.
  ///
  /// In en, this message translates to:
  /// **'Due in {days} days'**
  String dueInDays(int days);

  /// No description provided for @formattedMileage.
  ///
  /// In en, this message translates to:
  /// **'{mileage} {unit}'**
  String formattedMileage(Object mileage, Object unit);

  /// No description provided for @week.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 week} other{{count} weeks}}'**
  String week(int count);

  /// No description provided for @month.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 month} other{{count} months}}'**
  String month(int count);

  /// No description provided for @year.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 year} other{{count} years}}'**
  String year(int count);

  /// No description provided for @weekly.
  ///
  /// In en, this message translates to:
  /// **'Weekly'**
  String get weekly;

  /// No description provided for @monthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get monthly;

  /// No description provided for @quarterly.
  ///
  /// In en, this message translates to:
  /// **'Quarterly'**
  String get quarterly;

  /// No description provided for @never.
  ///
  /// In en, this message translates to:
  /// **'Never'**
  String get never;

  /// No description provided for @weeks.
  ///
  /// In en, this message translates to:
  /// **'Weeks'**
  String get weeks;

  /// No description provided for @months.
  ///
  /// In en, this message translates to:
  /// **'Months'**
  String get months;

  /// No description provided for @years.
  ///
  /// In en, this message translates to:
  /// **'Years'**
  String get years;

  /// No description provided for @invalidAiAssistant.
  ///
  /// In en, this message translates to:
  /// **'Invalid AI assistant.'**
  String get invalidAiAssistant;

  /// No description provided for @askAssistantBody.
  ///
  /// In en, this message translates to:
  /// **'Ask about this car, its workshop manuals, maintenance, repairs, and troubleshooting.'**
  String get askAssistantBody;

  /// No description provided for @unableToLoadAiAssistant.
  ///
  /// In en, this message translates to:
  /// **'Unable to load AI assistant.\n{error}'**
  String unableToLoadAiAssistant(Object error);

  /// No description provided for @unableToLoadWorkshopManuals.
  ///
  /// In en, this message translates to:
  /// **'Unable to load workshop manuals.\n{error}'**
  String unableToLoadWorkshopManuals(Object error);

  /// No description provided for @assistantHint.
  ///
  /// In en, this message translates to:
  /// **'Ask about maintenance, specs, or procedures...'**
  String get assistantHint;

  /// No description provided for @unableToSendMessage.
  ///
  /// In en, this message translates to:
  /// **'Unable to send message.\n{error}'**
  String unableToSendMessage(Object error);

  /// No description provided for @assistantGreeting.
  ///
  /// In en, this message translates to:
  /// **'Hello. I have your workshop manuals loaded. What are we tackling today?'**
  String get assistantGreeting;

  /// No description provided for @invalidAiMaintenanceSuggestions.
  ///
  /// In en, this message translates to:
  /// **'Invalid AI maintenance suggestions.'**
  String get invalidAiMaintenanceSuggestions;

  /// No description provided for @suggestedSchedule.
  ///
  /// In en, this message translates to:
  /// **'Suggested Schedule'**
  String get suggestedSchedule;

  /// No description provided for @aiAdvisorAnalyzing.
  ///
  /// In en, this message translates to:
  /// **'AI Advisor is analyzing...'**
  String get aiAdvisorAnalyzing;

  /// No description provided for @aiSuggestionsBody.
  ///
  /// In en, this message translates to:
  /// **'Select the recommended maintenance items to add to your vehicle tracker.'**
  String get aiSuggestionsBody;

  /// No description provided for @confirmAddToSchedule.
  ///
  /// In en, this message translates to:
  /// **'Confirm & Add to Schedule'**
  String get confirmAddToSchedule;

  /// No description provided for @unableToGenerateAiSuggestions.
  ///
  /// In en, this message translates to:
  /// **'Unable to generate AI suggestions.\n{error}'**
  String unableToGenerateAiSuggestions(Object error);

  /// No description provided for @unableToAddSuggestions.
  ///
  /// In en, this message translates to:
  /// **'Unable to add suggestions.\n{error}'**
  String unableToAddSuggestions(Object error);

  /// No description provided for @priorityLabel.
  ///
  /// In en, this message translates to:
  /// **'{priority} priority'**
  String priorityLabel(Object priority);

  /// No description provided for @invalidRepairSection.
  ///
  /// In en, this message translates to:
  /// **'Invalid repair section.'**
  String get invalidRepairSection;

  /// No description provided for @newEntry.
  ///
  /// In en, this message translates to:
  /// **'New entry'**
  String get newEntry;

  /// No description provided for @repairOverviewBody.
  ///
  /// In en, this message translates to:
  /// **'Manage your vehicle\'s mechanical history and future upgrades.'**
  String get repairOverviewBody;

  /// No description provided for @repairs.
  ///
  /// In en, this message translates to:
  /// **'Repairs'**
  String get repairs;

  /// No description provided for @modifications.
  ///
  /// In en, this message translates to:
  /// **'Modifications'**
  String get modifications;

  /// No description provided for @planned.
  ///
  /// In en, this message translates to:
  /// **'Planned'**
  String get planned;

  /// No description provided for @past.
  ///
  /// In en, this message translates to:
  /// **'Past'**
  String get past;

  /// No description provided for @unableToLoadRepairs.
  ///
  /// In en, this message translates to:
  /// **'Unable to load repairs.\n{error}'**
  String unableToLoadRepairs(Object error);

  /// No description provided for @planRepair.
  ///
  /// In en, this message translates to:
  /// **'Plan {repair}'**
  String planRepair(Object repair);

  /// No description provided for @trackPastRepair.
  ///
  /// In en, this message translates to:
  /// **'Track past {repair}'**
  String trackPastRepair(Object repair);

  /// No description provided for @trackUpcomingBody.
  ///
  /// In en, this message translates to:
  /// **'Track something you still need to do.'**
  String get trackUpcomingBody;

  /// No description provided for @trackCompletedBody.
  ///
  /// In en, this message translates to:
  /// **'Log something that has already been completed.'**
  String get trackCompletedBody;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @updated.
  ///
  /// In en, this message translates to:
  /// **'Updated'**
  String get updated;

  /// No description provided for @repair.
  ///
  /// In en, this message translates to:
  /// **'repair'**
  String get repair;

  /// No description provided for @modification.
  ///
  /// In en, this message translates to:
  /// **'modification'**
  String get modification;

  /// No description provided for @noRepairYet.
  ///
  /// In en, this message translates to:
  /// **'No {collection} yet'**
  String noRepairYet(Object collection);

  /// No description provided for @emptyRepairBody.
  ///
  /// In en, this message translates to:
  /// **'Start by planning something upcoming or logging work that has already been finished.'**
  String get emptyRepairBody;

  /// No description provided for @invalidRepairEntry.
  ///
  /// In en, this message translates to:
  /// **'Invalid repair entry.'**
  String get invalidRepairEntry;

  /// No description provided for @repairEntryNotFound.
  ///
  /// In en, this message translates to:
  /// **'This repair entry could not be found.'**
  String get repairEntryNotFound;

  /// No description provided for @editEntry.
  ///
  /// In en, this message translates to:
  /// **'Edit Entry'**
  String get editEntry;

  /// No description provided for @newEntryTitle.
  ///
  /// In en, this message translates to:
  /// **'New Entry'**
  String get newEntryTitle;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get title;

  /// No description provided for @areaOfVehicle.
  ///
  /// In en, this message translates to:
  /// **'Area of vehicle'**
  String get areaOfVehicle;

  /// No description provided for @markAsModification.
  ///
  /// In en, this message translates to:
  /// **'Mark as modification'**
  String get markAsModification;

  /// No description provided for @markAsModificationBody.
  ///
  /// In en, this message translates to:
  /// **'Logs this as an upgrade rather than a repair.'**
  String get markAsModificationBody;

  /// No description provided for @urgency.
  ///
  /// In en, this message translates to:
  /// **'Urgency'**
  String get urgency;

  /// No description provided for @low.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get low;

  /// No description provided for @medium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get medium;

  /// No description provided for @high.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get high;

  /// No description provided for @completionDate.
  ///
  /// In en, this message translates to:
  /// **'Completion date'**
  String get completionDate;

  /// No description provided for @chooseDate.
  ///
  /// In en, this message translates to:
  /// **'Choose a date'**
  String get chooseDate;

  /// No description provided for @select.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get select;

  /// No description provided for @createEntry.
  ///
  /// In en, this message translates to:
  /// **'Create Entry'**
  String get createEntry;

  /// No description provided for @deleteRepair.
  ///
  /// In en, this message translates to:
  /// **'Delete Repair'**
  String get deleteRepair;

  /// No description provided for @unableToLoadRepairEntry.
  ///
  /// In en, this message translates to:
  /// **'Unable to load the repair entry.\n{error}'**
  String unableToLoadRepairEntry(Object error);

  /// No description provided for @chooseCompletionDateFirst.
  ///
  /// In en, this message translates to:
  /// **'Choose a completion date first.'**
  String get chooseCompletionDateFirst;

  /// No description provided for @unableToSaveEntry.
  ///
  /// In en, this message translates to:
  /// **'Unable to save this entry.\n{error}'**
  String unableToSaveEntry(Object error);

  /// No description provided for @deleteRepairTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete repair?'**
  String get deleteRepairTitle;

  /// No description provided for @deleteRepairBody.
  ///
  /// In en, this message translates to:
  /// **'This will remove the entry together with its parts and attachments.'**
  String get deleteRepairBody;

  /// No description provided for @unableToDeleteEntry.
  ///
  /// In en, this message translates to:
  /// **'Unable to delete this entry.\n{error}'**
  String unableToDeleteEntry(Object error);

  /// No description provided for @addPart.
  ///
  /// In en, this message translates to:
  /// **'Add Part'**
  String get addPart;

  /// No description provided for @editPart.
  ///
  /// In en, this message translates to:
  /// **'Edit Part'**
  String get editPart;

  /// No description provided for @link.
  ///
  /// In en, this message translates to:
  /// **'Link'**
  String get link;

  /// No description provided for @partsList.
  ///
  /// In en, this message translates to:
  /// **'Parts List'**
  String get partsList;

  /// No description provided for @noPartsAdded.
  ///
  /// In en, this message translates to:
  /// **'No parts added yet.'**
  String get noPartsAdded;

  /// No description provided for @noLink.
  ///
  /// In en, this message translates to:
  /// **'No link'**
  String get noLink;

  /// No description provided for @mediaFiles.
  ///
  /// In en, this message translates to:
  /// **'Media & Files'**
  String get mediaFiles;

  /// No description provided for @addPhotos.
  ///
  /// In en, this message translates to:
  /// **'Add photos'**
  String get addPhotos;

  /// No description provided for @addFiles.
  ///
  /// In en, this message translates to:
  /// **'Add files'**
  String get addFiles;

  /// No description provided for @unableToLoadRepairDetails.
  ///
  /// In en, this message translates to:
  /// **'Unable to load repair details.\n{error}'**
  String unableToLoadRepairDetails(Object error);

  /// No description provided for @editEntryTooltip.
  ///
  /// In en, this message translates to:
  /// **'Edit entry'**
  String get editEntryTooltip;

  /// No description provided for @completeRepair.
  ///
  /// In en, this message translates to:
  /// **'Complete Repair'**
  String get completeRepair;

  /// No description provided for @reopenRepair.
  ///
  /// In en, this message translates to:
  /// **'Reopen Repair'**
  String get reopenRepair;

  /// No description provided for @markCompletedTitle.
  ///
  /// In en, this message translates to:
  /// **'Mark as completed?'**
  String get markCompletedTitle;

  /// No description provided for @markCompletedBody.
  ///
  /// In en, this message translates to:
  /// **'Carful will move this planned repair into your past repairs using the current date.'**
  String get markCompletedBody;

  /// No description provided for @complete.
  ///
  /// In en, this message translates to:
  /// **'Complete'**
  String get complete;

  /// No description provided for @reopenRepairTitle.
  ///
  /// In en, this message translates to:
  /// **'Reopen repair?'**
  String get reopenRepairTitle;

  /// No description provided for @reopenRepairBody.
  ///
  /// In en, this message translates to:
  /// **'Carful will move this completed repair back into your planned list.'**
  String get reopenRepairBody;

  /// No description provided for @reopen.
  ///
  /// In en, this message translates to:
  /// **'Reopen'**
  String get reopen;

  /// No description provided for @unableToOpenLink.
  ///
  /// In en, this message translates to:
  /// **'Unable to open the link.'**
  String get unableToOpenLink;

  /// No description provided for @repairTypeRepair.
  ///
  /// In en, this message translates to:
  /// **'Repair'**
  String get repairTypeRepair;

  /// No description provided for @repairTypeModification.
  ///
  /// In en, this message translates to:
  /// **'Modification'**
  String get repairTypeModification;

  /// No description provided for @urgencyBadge.
  ///
  /// In en, this message translates to:
  /// **'{urgency} urgency'**
  String urgencyBadge(Object urgency);

  /// No description provided for @descriptionSection.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get descriptionSection;

  /// No description provided for @parts.
  ///
  /// In en, this message translates to:
  /// **'Parts'**
  String get parts;

  /// No description provided for @viewPart.
  ///
  /// In en, this message translates to:
  /// **'View part'**
  String get viewPart;

  /// No description provided for @gallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get gallery;

  /// No description provided for @files.
  ///
  /// In en, this message translates to:
  /// **'Files'**
  String get files;

  /// No description provided for @file.
  ///
  /// In en, this message translates to:
  /// **'FILE'**
  String get file;

  /// No description provided for @engineArea.
  ///
  /// In en, this message translates to:
  /// **'Engine'**
  String get engineArea;

  /// No description provided for @chassisArea.
  ///
  /// In en, this message translates to:
  /// **'Chassis'**
  String get chassisArea;

  /// No description provided for @bodyArea.
  ///
  /// In en, this message translates to:
  /// **'Body'**
  String get bodyArea;

  /// No description provided for @suspensionArea.
  ///
  /// In en, this message translates to:
  /// **'Suspension'**
  String get suspensionArea;

  /// No description provided for @electricsArea.
  ///
  /// In en, this message translates to:
  /// **'Electrics'**
  String get electricsArea;

  /// No description provided for @interiorArea.
  ///
  /// In en, this message translates to:
  /// **'Interior'**
  String get interiorArea;

  /// No description provided for @otherArea.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get otherArea;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'de',
    'en',
    'es',
    'fr',
    'it',
    'pl',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'it':
      return AppLocalizationsIt();
    case 'pl':
      return AppLocalizationsPl();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
