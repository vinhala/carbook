import type { LocaleMessages } from './en'

const es: LocaleMessages = {
  meta: {
    title: 'Carful - El garaje digital para propietarios DIY',
    description:
      'Carful ayuda a propietarios que trabajan en sus propios coches a seguir mantenimiento, reparaciones, modificaciones, manuales de taller y conocimiento asistido por IA.',
  },
  brand: {
    name: 'Carful',
    tagline: 'Diseñado para durar.',
    contactEmail: 'contact@carful.diy',
    publisher: 'Vincent Halasz',
    country: 'Alemania',
  },
  navigation: {
    primary: 'Navegación principal',
    footer: 'Navegación del pie',
    toggle: 'Abrir o cerrar navegación',
    home: 'Inicio de Carful',
    backHome: 'Volver a Carful',
    features: 'Funciones',
    ai: 'Asistente IA',
    value: 'Historial del vehículo',
    privacy: 'Privacidad',
    terms: 'Términos',
  },
  language: {
    label: 'Idioma',
  },
  store: {
    appStore: 'App Store',
    playStore: 'Google Play',
    appStoreAria: 'Descargar Carful en App Store',
    playStoreAria: 'Obtener Carful en Google Play',
  },
  landing: {
    hero: {
      eyebrow: 'Garaje digital para propietarios DIY',
      title: 'Guarda cada trabajo, pieza e intervalo de servicio en un lugar tranquilo.',
      body:
        'Carful te ayuda a organizar perfiles de vehículos, seguir mantenimiento, documentar reparaciones y modificaciones, tener manuales de taller cerca y hacer preguntas a un asistente IA sobre el coche en el que trabajas.',
    },
    mockup: {
      aria: 'Vista previa de la app Carful',
      activeProfile: 'Perfil activo',
      vehicle: 'BMW 328i de 1998',
      engine: 'M52B28 - 142.380 km',
      warning: 'Mantenimiento vencido',
      warningDetail: 'Líquido de frenos - 24 días de retraso',
      health: 'Preparación del garaje',
      healthValue: '88%',
      repairTitle: 'Renovación de suspensión delantera',
      repairMeta: 'Reparación planificada - urgencia alta',
      logTitle: 'Aceite y filtro',
      logMeta: 'Completado - 141.900 km',
    },
    featureEyebrow: 'Ventajas de Carful',
    featuresHeading: 'Creado para el trabajo que mantiene vivo un coche.',
    featuresBody:
      'Tanto si conservas un coche diario como si planeas un proyecto de fin de semana, Carful mantiene los detalles localizables cuando ya tienes las manos ocupadas.',
    features: [
      {
        title: 'Perfiles de vehículo que recuerdan los detalles',
        body:
          'Guarda marca, modelo, motor, primera matriculación, VIN, kilometraje actual, unidades, fotos y preferencias de recordatorios para cada coche que cuidas.',
      },
      {
        title: 'Planes de mantenimiento sin adivinar',
        body:
          'Sigue trabajos recurrentes por distancia o tiempo, registra servicios completados y ve qué está vencido antes de que un descuido pequeño sea caro.',
      },
      {
        title: 'Registros de reparaciones y modificaciones',
        body:
          'Planifica trabajos futuros con urgencia, piezas, archivos e imágenes, y conviértelos en historial completado cuando termines.',
      },
      {
        title: 'Manuales de taller siempre cerca',
        body:
          'Adjunta manuales a un perfil para que la información fiable quede organizada con el coche exacto al que pertenece.',
      },
    ],
    ai: {
      eyebrow: 'Conocimiento de garaje asistido por IA',
      title: 'Pregunta en el contexto de tu coche real.',
      body:
        'Carful puede usar tu perfil, plan de mantenimiento, historial de reparaciones y manuales de taller para generar tareas y responder preguntas específicas del vehículo. Está diseñado para apoyar el trabajo cuidadoso, no para sustituir el criterio profesional.',
      previewAria: 'Vista previa del asistente IA',
      user: 'Tú',
      question: '¿Qué debo revisar antes de cambiar la bomba de agua?',
      answer:
        'Empieza por el procedimiento del manual, revisa el recorrido de la correa, el estado del refrigerante, las superficies de junta, la secuencia de apriete y las mangueras cercanas mientras la parte frontal del motor está abierta.',
    },
    value: {
      title: 'Un coche bien documentado inspira más confianza.',
      body:
        'Los registros claros facilitan el mantenimiento, ayudan a planificar piezas antes de empezar y crean un historial útil para diagnósticos futuros o conversaciones de venta.',
      trustAria: 'Puntos de confianza de Carful',
      trust: ['Registros locales primero', 'IA consciente de manuales', 'Creado para trabajo DIY'],
    },
  },
  legal: {
    updated: 'Última actualización: 28 de abril de 2026',
    privacyTitle: 'Política de privacidad',
    termsTitle: 'Términos del servicio',
    privacy: [
      {
        heading: '1. Responsable',
        body:
          'El responsable de Carful es {publisher}, {country}. Puedes contactar con el responsable para solicitudes de privacidad y RGPD en {email}.',
      },
      {
        heading: '2. Qué procesa Carful',
        body:
          'Carful está diseñado como un acompañante de vehículo con prioridad local. Según cómo uses la app, puede procesar detalles del perfil del vehículo, kilometraje, unidades de distancia, VIN, información del motor, fotos, planes de mantenimiento, registros de mantenimiento, reparaciones y modificaciones, piezas, enlaces, adjuntos, manuales de taller, preguntas y respuestas del asistente IA y datos técnicos necesarios para operar los servicios backend.',
      },
      {
        heading: '3. Almacenamiento local y funciones backend',
        body:
          'Los registros principales del vehículo se almacenan en tu dispositivo. Las funciones que usan procesamiento de manuales, sugerencias de mantenimiento o el asistente IA pueden enviar contexto relevante del vehículo, archivos o metadatos de manuales, tareas de mantenimiento, resúmenes de reparación y tus mensajes a los servicios backend de Carful para que la función solicitada pueda funcionar.',
      },
      {
        heading: '4. IA y encargados externos',
        body:
          'Las funciones de IA pueden ser procesadas por OpenAI o proveedores equivalentes de infraestructura de IA. Estos servicios pueden recibir el contenido necesario para responder a tu solicitud, como tu prompt, contexto del perfil, resúmenes de reparaciones, tareas de mantenimiento y contenido de manuales. No envíes mediante funciones de IA información que no quieras que se procese con este fin.',
      },
      {
        heading: '5. Bases legales',
        body:
          'Carful procesa datos para proporcionar la app y las funciones solicitadas por ejecución contractual, para operar y proteger el servicio por intereses legítimos, para cumplir obligaciones legales y, cuando sea necesario, con tu consentimiento. Puedes retirar el consentimiento cuando el procesamiento dependa de él.',
      },
      {
        heading: '6. Conservación',
        body:
          'Los registros locales permanecen en tu dispositivo hasta que los borres o elimines la app. Los registros backend, manuales subidos, metadatos de conversaciones del asistente y registros técnicos se conservan solo mientras sea necesario para proporcionar el servicio, resolver problemas, proteger el servicio o cumplir obligaciones legales. Puedes solicitar la eliminación escribiendo a {email}.',
      },
      {
        heading: '7. Tus derechos RGPD',
        body:
          'Cuando se aplique el RGPD, puedes solicitar acceso, rectificación, supresión, limitación del tratamiento, portabilidad de datos u oponerte al tratamiento. También puedes retirar el consentimiento cuando corresponda y presentar una reclamación ante una autoridad de protección de datos.',
      },
      {
        heading: '8. Transferencias internacionales',
        body:
          'Algunos proveedores backend o de IA pueden procesar datos fuera del Espacio Económico Europeo. Cuando ocurra, Carful se apoya en garantías adecuadas como protecciones contractuales u otros mecanismos de transferencia reconocidos legalmente.',
      },
      {
        heading: '9. Menores',
        body:
          'Carful está pensado para personas que mantienen o documentan vehículos. No está dirigido a menores, y los menores no deberían usar la app sin participación adecuada de un padre, madre o tutor.',
      },
      {
        heading: '10. Cambios',
        body:
          'Esta política puede actualizarse a medida que Carful evolucione. Las actualizaciones importantes se reflejarán en esta página.',
      },
    ],
    terms: [
      {
        heading: '1. Proveedor',
        body:
          'Carful es proporcionado por {publisher}, {country}. Para soporte, privacidad o cuestiones legales, contacta con {email}.',
      },
      {
        heading: '2. Qué hace Carful',
        body:
          'Carful ayuda a los usuarios a organizar perfiles de vehículos, kilometraje, planes de mantenimiento, reparaciones, modificaciones, manuales de taller y preguntas sobre vehículos asistidas por IA. La app es una herramienta de documentación y planificación. No realiza reparaciones ni garantiza la seguridad, aptitud para circular, valor o cumplimiento legal de un vehículo.',
      },
      {
        heading: '3. Tu responsabilidad',
        body:
          'Eres responsable de la exactitud de la información que introduces y de las decisiones que tomas al mantener, reparar, modificar, conducir, vender o inspeccionar un vehículo. Sigue siempre la documentación del fabricante, usa herramientas y equipo de seguridad adecuados y consulta a un profesional cualificado cuando una tarea pueda afectar a la seguridad o legalidad.',
      },
      {
        heading: '4. Limitaciones del asistente IA',
        body:
          'Las respuestas generadas por IA pueden ser incompletas, desactualizadas o incorrectas. La salida de IA se ofrece solo como apoyo de comodidad y planificación. No es asesoramiento profesional mecánico, técnico, de seguridad, legal o de inspección. Verifica la información importante con manuales, guía del fabricante y profesionales cualificados antes de actuar.',
      },
      {
        heading: '5. Uso aceptable',
        body:
          'No uses Carful para enviar contenido ilícito, infringir derechos de terceros, abusar del backend, eludir límites o controles de seguridad, ni solicitar instrucciones para actividades de vehículo inseguras o ilegales. El acceso puede limitarse o rechazarse si el uso supone riesgo para el servicio u otras personas.',
      },
      {
        heading: '6. Tu contenido',
        body:
          'Conservas la propiedad de los registros, fotos, manuales, archivos y mensajes que añades a Carful. Concedes a Carful el permiso limitado necesario para almacenar, procesar, transmitir y mostrar ese contenido para que funcionen la app y las funciones backend o de IA solicitadas.',
      },
      {
        heading: '7. Propiedad intelectual',
        body:
          'El nombre Carful, el diseño de la app, el software y los materiales relacionados están protegidos por leyes de propiedad intelectual. Estos términos no te otorgan derechos para copiar, modificar, distribuir o aplicar ingeniería inversa a la app salvo donde la ley lo permita.',
      },
      {
        heading: '8. Disponibilidad y cambios',
        body:
          'Carful puede cambiar con el tiempo, y algunas funciones pueden depender de plataformas móviles, servicios backend, acceso de red o proveedores externos. El servicio puede interrumpirse, cambiarse o discontinuarse.',
      },
      {
        heading: '9. Responsabilidad',
        body:
          'En la medida permitida por la ley, Carful se proporciona sin garantías de disponibilidad ininterrumpida, exactitud, idoneidad para un fin concreto o funcionamiento sin errores. Nada en estos términos limita responsabilidades cuando no puedan limitarse legalmente, incluidos dolo o derechos obligatorios de consumidores.',
      },
      {
        heading: '10. Contexto legal',
        body:
          'Estos términos están pensados para la operación de Carful por un editor individual en Alemania. Los derechos obligatorios de consumidores y la ley aplicable no se ven afectados.',
      },
    ],
  },
}

export default defineI18nLocale(() => es)
