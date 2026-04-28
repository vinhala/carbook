export const en = {
  brand: {
    name: 'Carful',
    tagline: 'Engineered for the long haul.',
    contactEmail: 'contact@carful.diy',
    publisher: 'Vincent Halasz',
    country: 'Germany',
  },
  navigation: {
    features: 'Features',
    ai: 'AI assistant',
    value: 'Vehicle history',
    privacy: 'Privacy',
    terms: 'Terms',
  },
  store: {
    appStore: 'App Store',
    playStore: 'Google Play',
    appStoreAria: 'Download Carful on the App Store',
    playStoreAria: 'Get Carful on Google Play',
  },
  landing: {
    hero: {
      eyebrow: 'Digital garage for DIY car owners',
      title: 'Keep every job, part, and service interval in one calm place.',
      body:
        'Carful helps you organize vehicle profiles, track maintenance, document repairs and modifications, keep workshop manuals close, and ask an AI assistant questions about the car you are working on.',
    },
    mockup: {
      vehicle: '1998 BMW 328i',
      engine: 'M52B28 • 142,380 km',
      warning: 'Maintenance overdue',
      warningDetail: 'Brake fluid service • 24 days past due',
      health: 'Garage readiness',
      healthValue: '88%',
      repairTitle: 'Front suspension refresh',
      repairMeta: 'Planned repair • High urgency',
      logTitle: 'Oil and filter',
      logMeta: 'Completed • 141,900 km',
    },
    featuresHeading: 'Built for the work that keeps a car alive.',
    featuresBody:
      'Whether you are preserving a daily driver or planning a weekend build, Carful keeps the details findable when your hands are already full.',
    features: [
      {
        title: 'Vehicle profiles that remember the details',
        body:
          'Store make, model, engine, first registration, VIN, current mileage, units, photos, and reminder preferences for every car you care for.',
      },
      {
        title: 'Maintenance schedules without guesswork',
        body:
          'Track recurring work by mileage or time, log completed service, and see what is overdue before small neglect becomes expensive.',
      },
      {
        title: 'Repair and modification records',
        body:
          'Plan future jobs with urgency, parts, files, and images, then convert them into completed history when the work is done.',
      },
      {
        title: 'Workshop manuals close at hand',
        body:
          'Attach manuals to a vehicle profile so the information you trust is organized with the exact car it belongs to.',
      },
    ],
    ai: {
      eyebrow: 'AI-assisted garage knowledge',
      title: 'Ask questions in the context of your actual car.',
      body:
        'Carful can use your profile, maintenance schedule, repair history, and workshop manuals to help generate maintenance items and answer vehicle-specific questions. It is designed to support careful work, not replace professional judgement.',
      question: 'What should I check before replacing the water pump?',
      answer:
        'Start with the service manual procedure, inspect belt routing, coolant condition, gasket surfaces, torque sequence, and any related hoses you can reach while the front of the engine is open.',
    },
    value: {
      title: 'A well-documented car is easier to trust.',
      body:
        'Clear records make maintenance easier, help you plan parts before a job starts, and create a useful history for future troubleshooting or resale conversations.',
    },
  },
  legal: {
    updated: 'Last updated: April 28, 2026',
    privacyTitle: 'Privacy Policy',
    termsTitle: 'Terms of Service',
  },
}

export type LocaleMessages = typeof en
