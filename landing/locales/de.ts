import type { LocaleMessages } from './en'

const de: LocaleMessages = {
  meta: {
    title: 'Carful - Die digitale Garage fuer DIY-Autobesitzer',
    description:
      'Carful hilft DIY-Autobesitzern, Wartung, Reparaturen, Umbauten, Werkstatthandbuecher und KI-gestuetztes Fahrzeugwissen zu verwalten.',
  },
  brand: {
    name: 'Carful',
    tagline: 'Gebaut fuer die lange Strecke.',
    contactEmail: 'contact@carful.diy',
    publisher: 'Vincent Halasz',
    country: 'Deutschland',
  },
  navigation: {
    primary: 'Hauptnavigation',
    footer: 'Footer-Navigation',
    toggle: 'Navigation umschalten',
    home: 'Carful Startseite',
    backHome: 'Zurueck zu Carful',
    features: 'Funktionen',
    ai: 'KI-Assistent',
    value: 'Fahrzeughistorie',
    privacy: 'Datenschutz',
    terms: 'Bedingungen',
  },
  language: {
    label: 'Sprache',
  },
  store: {
    appStore: 'App Store',
    playStore: 'Google Play',
    appStoreAria: 'Carful im App Store laden',
    playStoreAria: 'Carful bei Google Play laden',
  },
  landing: {
    hero: {
      eyebrow: 'Digitale Garage fuer DIY-Autobesitzer',
      title: 'Behalte jede Arbeit, jedes Teil und jedes Intervall an einem ruhigen Ort.',
      body:
        'Carful hilft dir, Fahrzeugprofile zu organisieren, Wartung zu verfolgen, Reparaturen und Umbauten zu dokumentieren, Werkstatthandbuecher griffbereit zu halten und einem KI-Assistenten Fragen zum Auto zu stellen, an dem du arbeitest.',
    },
    mockup: {
      aria: 'Vorschau der Carful App',
      activeProfile: 'Aktives Profil',
      vehicle: '1998 BMW 328i',
      engine: 'M52B28 - 142.380 km',
      warning: 'Wartung ueberfaellig',
      warningDetail: 'Bremsfluessigkeit - 24 Tage ueberfaellig',
      health: 'Garage-Bereitschaft',
      healthValue: '88%',
      repairTitle: 'Vorderachse auffrischen',
      repairMeta: 'Geplante Reparatur - hohe Dringlichkeit',
      logTitle: 'Oel und Filter',
      logMeta: 'Abgeschlossen - 141.900 km',
    },
    featureEyebrow: 'Carful Vorteile',
    featuresHeading: 'Gebaut fuer die Arbeit, die ein Auto am Leben haelt.',
    featuresBody:
      'Ob du einen Alltagswagen erhaeltst oder ein Wochenendprojekt planst: Carful sorgt dafuer, dass Details auffindbar bleiben, wenn deine Haende schon voll sind.',
    features: [
      {
        title: 'Fahrzeugprofile, die Details behalten',
        body:
          'Speichere Marke, Modell, Motor, Erstzulassung, VIN, aktuellen Kilometerstand, Einheiten, Fotos und Erinnerungseinstellungen fuer jedes Auto, das dir wichtig ist.',
      },
      {
        title: 'Wartungsplaene ohne Raetselraten',
        body:
          'Verfolge wiederkehrende Arbeiten nach Kilometerstand oder Zeit, protokolliere erledigte Wartung und sieh, was ueberfaellig ist, bevor kleine Nachlaessigkeit teuer wird.',
      },
      {
        title: 'Reparatur- und Umbauhistorie',
        body:
          'Plane kuenftige Arbeiten mit Dringlichkeit, Teilen, Dateien und Bildern und wandle sie nach Abschluss in nachvollziehbare Historie um.',
      },
      {
        title: 'Werkstatthandbuecher direkt am Fahrzeug',
        body:
          'Haenge Handbuecher an ein Fahrzeugprofil, damit die Informationen, denen du vertraust, beim richtigen Auto liegen.',
      },
    ],
    ai: {
      eyebrow: 'KI-gestuetztes Garage-Wissen',
      title: 'Stelle Fragen im Kontext deines echten Autos.',
      body:
        'Carful kann dein Profil, den Wartungsplan, die Reparaturhistorie und Werkstatthandbuecher nutzen, um Wartungspunkte zu erzeugen und fahrzeugspezifische Fragen zu beantworten. Es unterstuetzt sorgfaeltige Arbeit, ersetzt aber kein professionelles Urteil.',
      previewAria: 'Vorschau des KI-Assistenten',
      user: 'Du',
      question: 'Was sollte ich pruefen, bevor ich die Wasserpumpe ersetze?',
      answer:
        'Beginne mit dem Ablauf im Werkstatthandbuch und pruefe Riemenfuehrung, Kuehlmittelzustand, Dichtflaechen, Drehmomentfolge und erreichbare Schlaeuche, solange die Motorfront offen ist.',
    },
    value: {
      title: 'Ein gut dokumentiertes Auto ist leichter zu vertrauen.',
      body:
        'Klare Aufzeichnungen erleichtern Wartung, helfen bei der Teileplanung vor dem Start und schaffen eine nuetzliche Historie fuer Fehlersuche oder Verkaufsfragen.',
      trustAria: 'Carful Vertrauenspunkte',
      trust: ['Lokale Aufzeichnungen zuerst', 'Handbuchbewusste KI', 'Gebaut fuer DIY-Arbeit'],
    },
  },
  legal: {
    updated: 'Zuletzt aktualisiert: 28. April 2026',
    privacyTitle: 'Datenschutzerklaerung',
    termsTitle: 'Nutzungsbedingungen',
    privacy: [
      {
        heading: '1. Verantwortlicher',
        body:
          'Verantwortlich fuer Carful ist {publisher}, {country}. Fuer Datenschutz- und DSGVO-Anfragen erreichst du den Verantwortlichen unter {email}.',
      },
      {
        heading: '2. Welche Daten Carful verarbeitet',
        body:
          'Carful ist als lokal orientierter Fahrzeugbegleiter konzipiert. Je nach Nutzung kann die App Fahrzeugprofildaten, Kilometerstand, Einheiten, VIN, Motorinformationen, Fotos, Wartungsplaene, Wartungsprotokolle, Reparatur- und Umbauaufzeichnungen, Teile, Links, Anhaenge, Werkstatthandbuecher, KI-Assistenten-Eingaben und Antworten sowie technische Daten verarbeiten, die fuer den Betrieb der Backend-Dienste notwendig sind.',
      },
      {
        heading: '3. Lokale Speicherung und Backend-Funktionen',
        body:
          'Kernaufzeichnungen zum Fahrzeug werden auf deinem Geraet gespeichert. Funktionen fuer Werkstatthandbuchverarbeitung, Wartungsvorschlaege oder den KI-Assistenten koennen relevante Fahrzeugkontexte, Handbuchdateien oder Metadaten, Wartungspunkte, Reparaturzusammenfassungen und deine Nachrichten an Carful Backend-Dienste senden, damit die angeforderte Funktion arbeiten kann.',
      },
      {
        heading: '4. KI und Drittanbieter',
        body:
          'KI-Funktionen koennen von OpenAI oder vergleichbaren KI-Infrastrukturanbietern verarbeitet werden. Diese Dienste koennen Inhalte erhalten, die zur Beantwortung deiner Anfrage erforderlich sind, etwa deine Eingabe, Fahrzeugprofilkontext, Reparaturhistorie, Wartungspunkte und Inhalte aus Werkstatthandbuechern. Uebermittle ueber KI-Funktionen keine Informationen, die du dafuer nicht verarbeitet haben moechtest.',
      },
      {
        heading: '5. Rechtsgrundlagen',
        body:
          'Carful verarbeitet Daten zur Bereitstellung der App und angeforderter Funktionen im Rahmen der Vertragserfuellung, zum Betrieb und Schutz des Dienstes auf Grundlage berechtigter Interessen, zur Erfuellung rechtlicher Pflichten und, soweit erforderlich, auf Grundlage deiner Einwilligung. Eine Einwilligung kannst du widerrufen, wenn die Verarbeitung darauf beruht.',
      },
      {
        heading: '6. Aufbewahrung',
        body:
          'Lokale Aufzeichnungen bleiben auf deinem Geraet, bis du sie loeschst oder die App entfernst. Backend-Datensaetze, hochgeladene Handbuecher, Metadaten zu Assistentengesprächen und technische Protokolle werden nur so lange aufbewahrt, wie es fuer Dienstbereitstellung, Fehlerbehebung, Schutz des Dienstes oder rechtliche Pflichten erforderlich ist. Loeschung kannst du unter {email} anfragen.',
      },
      {
        heading: '7. Deine DSGVO-Rechte',
        body:
          'Soweit die DSGVO gilt, kannst du Auskunft, Berichtigung, Loeschung, Einschraenkung der Verarbeitung, Datenuebertragbarkeit oder Widerspruch gegen die Verarbeitung verlangen. Du kannst auch eine Einwilligung widerrufen und dich bei einer Datenschutzaufsichtsbehoerde beschweren.',
      },
      {
        heading: '8. Internationale Uebermittlungen',
        body:
          'Einige Backend- oder KI-Anbieter koennen Daten ausserhalb des Europaeischen Wirtschaftsraums verarbeiten. In solchen Faellen stuetzt sich Carful auf geeignete Garantien wie vertragliche Schutzmassnahmen oder andere rechtlich anerkannte Uebermittlungsmechanismen.',
      },
      {
        heading: '9. Kinder',
        body:
          'Carful richtet sich an Menschen, die Fahrzeuge warten oder dokumentieren. Die App richtet sich nicht an Kinder; Kinder sollten sie nur mit angemessener Beteiligung von Eltern oder Erziehungsberechtigten nutzen.',
      },
      {
        heading: '10. Aenderungen',
        body:
          'Diese Richtlinie kann aktualisiert werden, wenn sich Carful weiterentwickelt. Wesentliche Aktualisierungen werden auf dieser Seite angezeigt.',
      },
    ],
    terms: [
      {
        heading: '1. Anbieter',
        body:
          'Carful wird bereitgestellt von {publisher}, {country}. Fuer Support, Datenschutz- oder Rechtsfragen kontaktiere {email}.',
      },
      {
        heading: '2. Was Carful macht',
        body:
          'Carful hilft Nutzern, Fahrzeugprofile, Kilometerstand, Wartungsplaene, Reparaturen, Umbauten, Werkstatthandbuecher und KI-gestuetzte Fahrzeugfragen zu organisieren. Die App ist ein Dokumentations- und Planungstool. Sie fuehrt keine Reparaturen aus und garantiert nicht Sicherheit, Verkehrstauglichkeit, Wert oder rechtliche Konformitaet eines Fahrzeugs.',
      },
      {
        heading: '3. Deine Verantwortung',
        body:
          'Du bist verantwortlich fuer die Richtigkeit deiner Eingaben und fuer Entscheidungen beim Warten, Reparieren, Umbauen, Fahren, Verkaufen oder Pruefen eines Fahrzeugs. Folge immer der Herstellerdokumentation, nutze geeignete Werkzeuge und Sicherheitsausruestung und konsultiere Fachleute, wenn eine Aufgabe Sicherheit oder Recht betrifft.',
      },
      {
        heading: '4. Grenzen des KI-Assistenten',
        body:
          'KI-generierte Antworten koennen unvollstaendig, veraltet oder falsch sein. KI-Ausgaben dienen nur der Bequemlichkeit und Planung. Sie sind keine professionelle mechanische, technische, sicherheitsbezogene, rechtliche oder Pruefberatung. Pruefe wichtige Informationen anhand von Werkstatthandbuechern, Herstellerangaben und qualifizierten Fachleuten, bevor du handelst.',
      },
      {
        heading: '5. Zulaessige Nutzung',
        body:
          'Nutze Carful nicht, um rechtswidrige Inhalte zu uebermitteln, Rechte Dritter zu verletzen, das Backend zu missbrauchen, Ratenlimits oder Sicherheitskontrollen zu umgehen oder Anleitungen fuer unsichere oder rechtswidrige Fahrzeugaktivitaeten anzufordern. Der Zugriff kann eingeschraenkt oder verweigert werden, wenn die Nutzung den Dienst oder andere gefaehrdet.',
      },
      {
        heading: '6. Deine Inhalte',
        body:
          'Du behaeltst das Eigentum an Fahrzeugdaten, Fotos, Handbuechern, Dateien und Nachrichten, die du zu Carful hinzufuegst. Du erteilst Carful die begrenzte Erlaubnis, diese Inhalte zu speichern, zu verarbeiten, zu uebertragen und anzuzeigen, soweit dies fuer App, Backend- oder KI-Funktionen erforderlich ist.',
      },
      {
        heading: '7. Geistiges Eigentum',
        body:
          'Der Name Carful, das App-Design, die Software und zugehoerige Materialien sind durch Gesetze zum geistigen Eigentum geschuetzt. Diese Bedingungen gewaehren dir keine Rechte zum Kopieren, Veraendern, Verbreiten oder Reverse Engineering der App, ausser soweit gesetzlich erlaubt.',
      },
      {
        heading: '8. Verfuegbarkeit und Aenderungen',
        body:
          'Carful kann sich mit der Zeit aendern, und einige Funktionen koennen von mobilen Plattformen, Backend-Diensten, Netzwerkzugang oder Drittanbietern abhaengen. Der Dienst kann unterbrochen, geaendert oder eingestellt werden.',
      },
      {
        heading: '9. Haftung',
        body:
          'Soweit gesetzlich zulaessig, wird Carful ohne Gewaehr fuer ununterbrochene Verfuegbarkeit, Richtigkeit, Eignung fuer einen bestimmten Zweck oder fehlerfreien Betrieb bereitgestellt. Nichts in diesen Bedingungen beschraenkt Haftung, soweit sie rechtlich nicht beschraenkt werden darf, einschliesslich Vorsatz oder zwingender Verbraucherrechte.',
      },
      {
        heading: '10. Rechtlicher Kontext',
        body:
          'Diese Bedingungen sind fuer den Betrieb von Carful durch einen einzelnen Anbieter in Deutschland gedacht. Zwingende Verbraucherrechte und anwendbares Recht bleiben unberuehrt.',
      },
    ],
  },
}

export default defineI18nLocale(() => de)
