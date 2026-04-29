// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'Carful';

  @override
  String get addCar => 'Aggiungi auto';

  @override
  String unableToLoadGarage(Object error) {
    return 'Unable to load your garage.\n$error';
  }

  @override
  String get garageEmptyTitle => 'Il tuo garage è pronto';

  @override
  String get garageEmptyBody =>
      'Crea il primo profilo auto per iniziare a seguire chilometraggio e promemoria.';

  @override
  String get createFirstProfile => 'Crea primo profilo';

  @override
  String get invalidCarProfile => 'Invalid car profile.';

  @override
  String get carProfileNotFound => 'This car profile could not be found.';

  @override
  String unableToLoadProfile(Object error) {
    return 'Unable to load the profile.\n$error';
  }

  @override
  String unableToLoadCarProfile(Object error) {
    return 'Unable to load the car profile.\n$error';
  }

  @override
  String get editProfile => 'Modifica profilo';

  @override
  String get addNewCar => 'Aggiungi nuova auto';

  @override
  String get backToGarage => 'Back to garage';

  @override
  String get tapToAddCarPhoto => 'Tap to add a car photo';

  @override
  String get make => 'Make';

  @override
  String get model => 'Model';

  @override
  String get engine => 'Engine';

  @override
  String get vin => 'VIN';

  @override
  String get firstRegistration => 'First registration';

  @override
  String get miles => 'Miles';

  @override
  String get kilometers => 'Kilometers';

  @override
  String get currentMileage => 'Current mileage';

  @override
  String get mileageReminders => 'Mileage reminders';

  @override
  String get mileageReminderHelp =>
      'Choose how often Carful should remind you to update mileage for this car.';

  @override
  String get reminderOffWarning =>
      'Turning reminders off can make it easier to miss critical maintenance intervals.';

  @override
  String get quarterlyReminderWarning =>
      'Quarterly reminders can be too sparse for cars that need close attention.';

  @override
  String get saveChanges => 'Save Changes';

  @override
  String get createProfile => 'Create Profile';

  @override
  String get deleteProfile => 'Delete Profile';

  @override
  String get fieldRequired => 'This field is required.';

  @override
  String get mileageRequired => 'Mileage is required.';

  @override
  String get mileagePositiveWholeNumber =>
      'Mileage must be a positive whole number.';

  @override
  String get selectFirstRegistrationMonth => 'Select first registration month';

  @override
  String unableToSaveCarProfile(Object error) {
    return 'Unable to save this car profile.\n$error';
  }

  @override
  String get deleteProfileTitle => 'Delete this profile?';

  @override
  String get deleteProfileBody =>
      'This removes the car profile and its mileage reminder schedule. This cannot be undone.';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String unableToDeleteProfile(Object error) {
    return 'Unable to delete this profile.\n$error';
  }

  @override
  String registeredDate(Object date) {
    return 'Registered $date';
  }

  @override
  String get mileage => 'Chilometraggio';

  @override
  String get updateMileage => 'Update mileage';

  @override
  String lastUpdatedOn(Object date) {
    return 'Last updated on $date';
  }

  @override
  String get vehicleDetails => 'Vehicle details';

  @override
  String get mileageReminder => 'Mileage reminder';

  @override
  String get mileageReminderWarningBody =>
      'This cadence can make it easier to miss critical maintenance intervals.';

  @override
  String get mileageReminderNudgeBody =>
      'Carful will keep nudging you to keep mileage fresh for future maintenance tracking.';

  @override
  String get maintenanceSchedule => 'Piano manutenzione';

  @override
  String get open => 'Apri';

  @override
  String get maintenanceScheduleCardBody =>
      'Track recurring maintenance, see what is overdue, and log completed service from one place.';

  @override
  String get maintenanceScheduleCardHint =>
      'Create mileage- or time-based items for this vehicle.';

  @override
  String get repairsModifications => 'Riparazioni e modifiche';

  @override
  String get repairsModificationsTitle => 'Riparazioni e modifiche';

  @override
  String get repairsModificationsBody =>
      'Keep planned repairs, completed fixes, and upgrades together so you always know what is next.';

  @override
  String plannedRepairCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count planned repairs',
      one: '1 planned repair',
    );
    return '$_temp0';
  }

  @override
  String get loadingPlannedRepairs => 'Loading planned repairs...';

  @override
  String get unableToLoadPlannedRepairs => 'Unable to load planned repairs.';

  @override
  String get workshopManuals => 'Manuali d’officina';

  @override
  String get adding => 'Adding...';

  @override
  String get addManual => 'Add manual';

  @override
  String get loadingManuals => 'Loading manuals...';

  @override
  String unableToLoadManuals(Object error) {
    return 'Unable to load manuals.\n$error';
  }

  @override
  String get addPdfManuals =>
      'Add PDF workshop manuals so Carful AI can answer questions about this vehicle and generate schedule suggestions.';

  @override
  String get aiAssistant => 'Assistente IA';

  @override
  String get aiAssistantReadyBody =>
      'Use your manuals, maintenance history, and repair context to answer vehicle-specific questions.';

  @override
  String get aiAssistantNeedsManual =>
      'Add at least one workshop manual to start using the assistant.';

  @override
  String get enterValidMileage => 'Enter a valid mileage.';

  @override
  String get save => 'Save';

  @override
  String unableToUpdateMileage(Object error) {
    return 'Unable to update mileage.\n$error';
  }

  @override
  String unableToAddWorkshopManuals(Object error) {
    return 'Unable to add workshop manuals.\n$error';
  }

  @override
  String unableToOpenFile(Object name) {
    return 'Unable to open $name.';
  }

  @override
  String get removeWorkshopManualTitle => 'Remove workshop manual?';

  @override
  String removeWorkshopManualBody(Object name) {
    return 'Carful will remove $name from this vehicle and the AI assistant context.';
  }

  @override
  String get remove => 'Remove';

  @override
  String unableToRemoveManual(Object error) {
    return 'Unable to remove manual.\n$error';
  }

  @override
  String get invalidMaintenanceSchedule => 'Invalid maintenance schedule.';

  @override
  String get maintenance => 'Maintenance';

  @override
  String get autoGenerateScheduleAi => 'Auto-generate schedule with AI';

  @override
  String get uploadManualsEnableAiSchedule =>
      'Upload manuals to enable AI schedule generation';

  @override
  String get newItem => 'New item';

  @override
  String unableToLoadMaintenanceItems(Object error) {
    return 'Unable to load maintenance items.\n$error';
  }

  @override
  String get noMaintenanceItemsYet => 'No maintenance items yet';

  @override
  String get maintenanceEmptyBody =>
      'Create your first recurring maintenance task to start tracking what is due next.';

  @override
  String get createMaintenanceItem => 'Create maintenance item';

  @override
  String get overdue => 'Overdue';

  @override
  String get upcoming => 'Upcoming';

  @override
  String nextTarget(Object target) {
    return 'Next target: $target';
  }

  @override
  String get nextTargetLabel => 'Prossimo obiettivo';

  @override
  String get log => 'Log';

  @override
  String get invalidMaintenanceItem => 'Invalid maintenance item.';

  @override
  String get maintenanceItemNotFound =>
      'This maintenance item could not be found.';

  @override
  String unableToLoadMaintenanceItem(Object error) {
    return 'Unable to load maintenance item.\n$error';
  }

  @override
  String get editMaintenanceItem => 'Edit Maintenance Item';

  @override
  String get newMaintenanceItem => 'New Maintenance Item';

  @override
  String get description => 'Description';

  @override
  String get oilChangeHint => 'Oil change';

  @override
  String get scheduleConfigurator => 'Schedule Configurator';

  @override
  String get distance => 'Distance';

  @override
  String get time => 'Time';

  @override
  String get distanceInterval => 'Distance interval';

  @override
  String get timeInterval => 'Time interval';

  @override
  String get timeUnit => 'Time unit';

  @override
  String get createItem => 'Create Item';

  @override
  String get createTimeBasedItem => 'Create Time-Based Item';

  @override
  String get deleteMaintenanceItem => 'Delete Maintenance Item';

  @override
  String get intervalRequired => 'Interval is required.';

  @override
  String get enterValidInterval => 'Enter a valid interval.';

  @override
  String unableToSaveMaintenanceItem(Object error) {
    return 'Unable to save maintenance item.\n$error';
  }

  @override
  String get deleteMaintenanceItemTitle => 'Delete maintenance item?';

  @override
  String get deleteMaintenanceItemBody =>
      'This will remove the item and its logged service history.';

  @override
  String unableToDeleteMaintenanceItem(Object error) {
    return 'Unable to delete maintenance item.\n$error';
  }

  @override
  String get backToMaintenance => 'Back to maintenance';

  @override
  String get logWork => 'Log work';

  @override
  String unableToLoadMaintenanceDetails(Object error) {
    return 'Unable to load maintenance details.\n$error';
  }

  @override
  String get nextRequiredWork => 'Next required work';

  @override
  String get status => 'Status';

  @override
  String get lastService => 'Last service';

  @override
  String get noWorkLoggedYet => 'No work logged yet';

  @override
  String get currentOdometer => 'Current odometer';

  @override
  String get serviceHistory => 'Service history';

  @override
  String get noPerformedWork =>
      'No performed work has been logged for this item yet.';

  @override
  String get logPerformedWork => 'Log Performed Work';

  @override
  String get date => 'Date';

  @override
  String get notes => 'Notes';

  @override
  String get notesHint => 'Optional notes about parts, fluids, or observations';

  @override
  String unableToLogPerformedWork(Object error) {
    return 'Unable to log performed work.\n$error';
  }

  @override
  String everyDistance(Object interval, Object unit) {
    return 'Every $interval $unit';
  }

  @override
  String everyTime(Object interval) {
    return 'Every $interval';
  }

  @override
  String overdueByDistance(Object distance, Object unit) {
    return 'Overdue by $distance $unit';
  }

  @override
  String get dueNow => 'Due now';

  @override
  String dueInDistance(Object distance, Object unit) {
    return 'Due in $distance $unit';
  }

  @override
  String get overdueByOneDay => 'Overdue by 1 day';

  @override
  String overdueByDays(int days) {
    return 'Overdue by $days days';
  }

  @override
  String get dueToday => 'Due today';

  @override
  String get dueInOneDay => 'Due in 1 day';

  @override
  String dueInDays(int days) {
    return 'Due in $days days';
  }

  @override
  String formattedMileage(Object mileage, Object unit) {
    return '$mileage $unit';
  }

  @override
  String week(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count weeks',
      one: '1 week',
    );
    return '$_temp0';
  }

  @override
  String month(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count months',
      one: '1 month',
    );
    return '$_temp0';
  }

  @override
  String year(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count years',
      one: '1 year',
    );
    return '$_temp0';
  }

  @override
  String get weekly => 'Weekly';

  @override
  String get monthly => 'Monthly';

  @override
  String get quarterly => 'Quarterly';

  @override
  String get never => 'Never';

  @override
  String get weeks => 'Weeks';

  @override
  String get months => 'Months';

  @override
  String get years => 'Years';

  @override
  String get invalidAiAssistant => 'Invalid AI assistant.';

  @override
  String get askAssistantBody =>
      'Ask about this car, its workshop manuals, maintenance, repairs, and troubleshooting.';

  @override
  String unableToLoadAiAssistant(Object error) {
    return 'Unable to load AI assistant.\n$error';
  }

  @override
  String unableToLoadWorkshopManuals(Object error) {
    return 'Unable to load workshop manuals.\n$error';
  }

  @override
  String get assistantHint => 'Ask about maintenance, specs, or procedures...';

  @override
  String unableToSendMessage(Object error) {
    return 'Unable to send message.\n$error';
  }

  @override
  String get assistantGreeting =>
      'Hello. I have your workshop manuals loaded. What are we tackling today?';

  @override
  String get invalidAiMaintenanceSuggestions =>
      'Invalid AI maintenance suggestions.';

  @override
  String get suggestedSchedule => 'Suggested Schedule';

  @override
  String get aiAdvisorAnalyzing => 'AI Advisor is analyzing...';

  @override
  String get aiSuggestionsBody =>
      'Select the recommended maintenance items to add to your vehicle tracker.';

  @override
  String get confirmAddToSchedule => 'Confirm & Add to Schedule';

  @override
  String unableToGenerateAiSuggestions(Object error) {
    return 'Unable to generate AI suggestions.\n$error';
  }

  @override
  String unableToAddSuggestions(Object error) {
    return 'Unable to add suggestions.\n$error';
  }

  @override
  String priorityLabel(Object priority) {
    return '$priority priority';
  }

  @override
  String get invalidRepairSection => 'Invalid repair section.';

  @override
  String get newEntry => 'New entry';

  @override
  String get repairOverviewBody =>
      'Manage your vehicle\'s mechanical history and future upgrades.';

  @override
  String get repairs => 'Repairs';

  @override
  String get modifications => 'Modifications';

  @override
  String get planned => 'Planned';

  @override
  String get past => 'Past';

  @override
  String unableToLoadRepairs(Object error) {
    return 'Unable to load repairs.\n$error';
  }

  @override
  String planRepair(Object repair) {
    return 'Plan $repair';
  }

  @override
  String trackPastRepair(Object repair) {
    return 'Track past $repair';
  }

  @override
  String get trackUpcomingBody => 'Track something you still need to do.';

  @override
  String get trackCompletedBody =>
      'Log something that has already been completed.';

  @override
  String get completed => 'Completed';

  @override
  String get updated => 'Updated';

  @override
  String get repair => 'repair';

  @override
  String get modification => 'modification';

  @override
  String noRepairYet(Object collection) {
    return 'No $collection yet';
  }

  @override
  String get emptyRepairBody =>
      'Start by planning something upcoming or logging work that has already been finished.';

  @override
  String get invalidRepairEntry => 'Invalid repair entry.';

  @override
  String get repairEntryNotFound => 'This repair entry could not be found.';

  @override
  String get editEntry => 'Edit Entry';

  @override
  String get newEntryTitle => 'New Entry';

  @override
  String get title => 'Title';

  @override
  String get areaOfVehicle => 'Area of vehicle';

  @override
  String get markAsModification => 'Mark as modification';

  @override
  String get markAsModificationBody =>
      'Logs this as an upgrade rather than a repair.';

  @override
  String get urgency => 'Urgency';

  @override
  String get low => 'Low';

  @override
  String get medium => 'Medium';

  @override
  String get high => 'High';

  @override
  String get completionDate => 'Completion date';

  @override
  String get chooseDate => 'Choose a date';

  @override
  String get select => 'Select';

  @override
  String get createEntry => 'Create Entry';

  @override
  String get deleteRepair => 'Delete Repair';

  @override
  String unableToLoadRepairEntry(Object error) {
    return 'Unable to load the repair entry.\n$error';
  }

  @override
  String get chooseCompletionDateFirst => 'Choose a completion date first.';

  @override
  String unableToSaveEntry(Object error) {
    return 'Unable to save this entry.\n$error';
  }

  @override
  String get deleteRepairTitle => 'Delete repair?';

  @override
  String get deleteRepairBody =>
      'This will remove the entry together with its parts and attachments.';

  @override
  String unableToDeleteEntry(Object error) {
    return 'Unable to delete this entry.\n$error';
  }

  @override
  String get addPart => 'Add Part';

  @override
  String get editPart => 'Edit Part';

  @override
  String get link => 'Link';

  @override
  String get partsList => 'Parts List';

  @override
  String get noPartsAdded => 'No parts added yet.';

  @override
  String get noLink => 'No link';

  @override
  String get mediaFiles => 'Media & Files';

  @override
  String get addPhotos => 'Add photos';

  @override
  String get addFiles => 'Add files';

  @override
  String unableToLoadRepairDetails(Object error) {
    return 'Unable to load repair details.\n$error';
  }

  @override
  String get editEntryTooltip => 'Edit entry';

  @override
  String get completeRepair => 'Complete Repair';

  @override
  String get reopenRepair => 'Reopen Repair';

  @override
  String get markCompletedTitle => 'Mark as completed?';

  @override
  String get markCompletedBody =>
      'Carful will move this planned repair into your past repairs using the current date.';

  @override
  String get complete => 'Complete';

  @override
  String get reopenRepairTitle => 'Reopen repair?';

  @override
  String get reopenRepairBody =>
      'Carful will move this completed repair back into your planned list.';

  @override
  String get reopen => 'Reopen';

  @override
  String get unableToOpenLink => 'Unable to open the link.';

  @override
  String get repairTypeRepair => 'Repair';

  @override
  String get repairTypeModification => 'Modification';

  @override
  String urgencyBadge(Object urgency) {
    return '$urgency urgency';
  }

  @override
  String get descriptionSection => 'Description';

  @override
  String get parts => 'Parts';

  @override
  String get viewPart => 'View part';

  @override
  String get gallery => 'Gallery';

  @override
  String get files => 'Files';

  @override
  String get file => 'FILE';

  @override
  String get engineArea => 'Engine';

  @override
  String get chassisArea => 'Chassis';

  @override
  String get bodyArea => 'Body';

  @override
  String get suspensionArea => 'Suspension';

  @override
  String get electricsArea => 'Electrics';

  @override
  String get interiorArea => 'Interior';

  @override
  String get otherArea => 'Other';
}
