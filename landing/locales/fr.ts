import type { LocaleMessages } from './en'

const fr: LocaleMessages = {
  meta: {
    title: 'Carful - Le garage numérique pour propriétaires DIY',
    description:
      'Carful aide les propriétaires qui entretiennent eux-mêmes leur voiture à suivre maintenance, réparations, modifications, manuels d’atelier et connaissances assistées par IA.',
  },
  brand: {
    name: 'Carful',
    tagline: 'Conçu pour durer.',
    contactEmail: 'contact@carful.diy',
    publisher: 'Vincent Halasz',
    country: 'Allemagne',
  },
  navigation: {
    primary: 'Navigation principale',
    footer: 'Navigation du pied de page',
    toggle: 'Ouvrir ou fermer la navigation',
    home: 'Accueil Carful',
    backHome: 'Retour à Carful',
    features: 'Fonctions',
    ai: 'Assistant IA',
    value: 'Historique du véhicule',
    privacy: 'Confidentialité',
    terms: 'Conditions',
  },
  language: {
    label: 'Langue',
  },
  store: {
    appStore: 'App Store',
    playStore: 'Google Play',
    appStoreAria: 'Télécharger Carful sur l’App Store',
    playStoreAria: 'Obtenir Carful sur Google Play',
  },
  landing: {
    hero: {
      eyebrow: 'Garage numérique pour propriétaires DIY',
      title: 'Gardez chaque tâche, pièce et intervalle d’entretien dans un endroit calme.',
      body:
        'Carful vous aide à organiser les profils de véhicules, suivre l’entretien, documenter réparations et modifications, garder les manuels d’atelier à portée de main et poser des questions à un assistant IA sur la voiture sur laquelle vous travaillez.',
    },
    mockup: {
      aria: 'Aperçu de l’application Carful',
      activeProfile: 'Profil actif',
      vehicle: 'BMW 328i 1998',
      engine: 'M52B28 - 142 380 km',
      warning: 'Entretien en retard',
      warningDetail: 'Liquide de frein - 24 jours de retard',
      health: 'Préparation du garage',
      healthValue: '88%',
      repairTitle: 'Rafraîchissement suspension avant',
      repairMeta: 'Réparation planifiée - urgence élevée',
      logTitle: 'Huile et filtre',
      logMeta: 'Terminé - 141 900 km',
    },
    featureEyebrow: 'Avantages Carful',
    featuresHeading: 'Pensé pour le travail qui garde une voiture en vie.',
    featuresBody:
      'Que vous préserviez une voiture de tous les jours ou prépariez un projet du week-end, Carful garde les détails faciles à retrouver quand vos mains sont déjà prises.',
    features: [
      {
        title: 'Des profils véhicule qui retiennent les détails',
        body:
          'Enregistrez marque, modèle, moteur, première immatriculation, VIN, kilométrage actuel, unités, photos et préférences de rappel pour chaque voiture dont vous vous occupez.',
      },
      {
        title: 'Des calendriers d’entretien sans devinettes',
        body:
          'Suivez les tâches récurrentes par distance ou durée, consignez les services effectués et voyez ce qui est en retard avant qu’un petit oubli ne coûte cher.',
      },
      {
        title: 'Dossiers de réparations et modifications',
        body:
          'Planifiez les prochains travaux avec urgence, pièces, fichiers et images, puis transformez-les en historique terminé une fois le travail fait.',
      },
      {
        title: 'Manuels d’atelier à portée de main',
        body:
          'Associez les manuels à un profil véhicule afin que les informations fiables restent avec la voiture exacte à laquelle elles appartiennent.',
      },
    ],
    ai: {
      eyebrow: 'Savoir de garage assisté par IA',
      title: 'Posez des questions dans le contexte de votre vraie voiture.',
      body:
        'Carful peut utiliser votre profil, calendrier d’entretien, historique de réparations et manuels d’atelier pour générer des tâches et répondre à des questions propres au véhicule. Il soutient un travail attentif, sans remplacer un avis professionnel.',
      previewAria: 'Aperçu de l’assistant IA',
      user: 'Vous',
      question: 'Que vérifier avant de remplacer la pompe à eau ?',
      answer:
        'Commencez par la procédure du manuel, vérifiez le cheminement de la courroie, l’état du liquide de refroidissement, les surfaces de joint, l’ordre de serrage et les durites accessibles tant que l’avant du moteur est ouvert.',
    },
    value: {
      title: 'Une voiture bien documentée inspire plus confiance.',
      body:
        'Des dossiers clairs facilitent l’entretien, aident à prévoir les pièces avant de commencer et créent un historique utile pour le dépannage ou la revente.',
      trustAria: 'Points de confiance Carful',
      trust: ['Dossiers locaux d’abord', 'IA attentive aux manuels', 'Conçu pour le DIY'],
    },
  },
  legal: {
    updated: 'Dernière mise à jour : 28 avril 2026',
    privacyTitle: 'Politique de confidentialité',
    termsTitle: 'Conditions d’utilisation',
    privacy: [
      {
        heading: '1. Responsable',
        body:
          'Le responsable de Carful est {publisher}, {country}. Vous pouvez le contacter pour les demandes de confidentialité et RGPD à {email}.',
      },
      {
        heading: '2. Ce que Carful traite',
        body:
          'Carful est conçu comme un compagnon véhicule local-first. Selon votre utilisation, l’application peut traiter les détails du profil véhicule, kilométrage, unités de distance, VIN, informations moteur, photos, calendriers d’entretien, journaux d’entretien, dossiers de réparations et modifications, pièces, liens, pièces jointes, manuels d’atelier, prompts et réponses de l’assistant IA, ainsi que les données techniques nécessaires au fonctionnement des services backend.',
      },
      {
        heading: '3. Stockage local et fonctions backend',
        body:
          'Les dossiers principaux du véhicule sont stockés sur votre appareil. Les fonctions utilisant le traitement de manuels, les suggestions d’entretien ou l’assistant IA peuvent envoyer aux services backend de Carful le contexte véhicule pertinent, des fichiers ou métadonnées de manuels, des éléments d’entretien, des résumés de réparation et vos messages afin que la fonction demandée fonctionne.',
      },
      {
        heading: '4. IA et sous-traitants tiers',
        body:
          'Les fonctions IA peuvent être traitées par OpenAI ou des fournisseurs équivalents d’infrastructure IA. Ces services peuvent recevoir le contenu nécessaire pour répondre à votre demande, par exemple votre prompt, le contexte du profil, des résumés de réparations, des éléments d’entretien et du contenu de manuels. Ne soumettez pas via les fonctions IA des informations que vous ne souhaitez pas voir traitées à cette fin.',
      },
      {
        heading: '5. Bases légales',
        body:
          'Carful traite les données pour fournir l’application et les fonctions demandées au titre de l’exécution contractuelle, pour exploiter et protéger le service au titre des intérêts légitimes, pour respecter des obligations légales et, lorsque nécessaire, sur la base de votre consentement. Vous pouvez retirer votre consentement lorsque le traitement en dépend.',
      },
      {
        heading: '6. Conservation',
        body:
          'Les dossiers locaux restent sur votre appareil jusqu’à leur suppression ou la désinstallation de l’application. Les dossiers backend, manuels téléversés, métadonnées de conversations assistant et journaux techniques sont conservés uniquement aussi longtemps que nécessaire pour fournir le service, résoudre les problèmes, protéger le service ou respecter des obligations légales. Vous pouvez demander leur suppression à {email}.',
      },
      {
        heading: '7. Vos droits RGPD',
        body:
          'Lorsque le RGPD s’applique, vous pouvez demander l’accès, la rectification, l’effacement, la limitation du traitement, la portabilité des données ou vous opposer au traitement. Vous pouvez également retirer votre consentement le cas échéant et déposer une réclamation auprès d’une autorité de protection des données.',
      },
      {
        heading: '8. Transferts internationaux',
        body:
          'Certains fournisseurs backend ou IA peuvent traiter des données hors de l’Espace économique européen. Dans ce cas, Carful s’appuie sur des garanties appropriées telles que des protections contractuelles ou d’autres mécanismes de transfert reconnus par la loi.',
      },
      {
        heading: '9. Enfants',
        body:
          'Carful s’adresse aux personnes qui entretiennent ou documentent des véhicules. L’application ne vise pas les enfants, qui ne devraient pas l’utiliser sans implication appropriée d’un parent ou tuteur.',
      },
      {
        heading: '10. Modifications',
        body:
          'Cette politique peut être mise à jour à mesure que Carful évolue. Les mises à jour importantes seront affichées sur cette page.',
      },
    ],
    terms: [
      {
        heading: '1. Fournisseur',
        body:
          'Carful est fourni par {publisher}, {country}. Pour le support, la confidentialité ou les questions juridiques, contactez {email}.',
      },
      {
        heading: '2. Ce que fait Carful',
        body:
          'Carful aide les utilisateurs à organiser profils véhicule, kilométrage, calendriers d’entretien, réparations, modifications, manuels d’atelier et questions véhicule assistées par IA. L’application est un outil de documentation et de planification. Elle n’effectue pas de réparations et ne garantit pas la sécurité, l’aptitude à circuler, la valeur ou la conformité légale d’un véhicule.',
      },
      {
        heading: '3. Votre responsabilité',
        body:
          'Vous êtes responsable de l’exactitude des informations saisies et des décisions prises lors de l’entretien, réparation, modification, conduite, vente ou inspection d’un véhicule. Suivez toujours la documentation du constructeur, utilisez des outils et équipements de sécurité appropriés et consultez un professionnel qualifié lorsqu’une tâche peut affecter la sécurité ou la légalité.',
      },
      {
        heading: '4. Limites de l’assistant IA',
        body:
          'Les réponses générées par IA peuvent être incomplètes, obsolètes ou incorrectes. La sortie IA est fournie uniquement pour le confort et l’aide à la planification. Elle ne constitue pas un conseil professionnel mécanique, technique, de sécurité, juridique ou d’inspection. Vérifiez les informations importantes dans les manuels, recommandations constructeur et auprès de professionnels qualifiés avant d’agir.',
      },
      {
        heading: '5. Utilisation acceptable',
        body:
          'N’utilisez pas Carful pour soumettre du contenu illégal, porter atteinte aux droits de tiers, abuser du backend, contourner des limites ou contrôles de sécurité, ou demander des instructions pour une activité véhicule dangereuse ou illégale. L’accès peut être limité ou refusé si l’utilisation risque de nuire au service ou à autrui.',
      },
      {
        heading: '6. Votre contenu',
        body:
          'Vous conservez la propriété des dossiers véhicule, photos, manuels, fichiers et messages ajoutés à Carful. Vous accordez à Carful l’autorisation limitée nécessaire pour stocker, traiter, transmettre et afficher ce contenu afin que l’application et les fonctions backend ou IA demandées fonctionnent.',
      },
      {
        heading: '7. Propriété intellectuelle',
        body:
          'Le nom Carful, la conception de l’application, le logiciel et les éléments associés sont protégés par les lois sur la propriété intellectuelle. Ces conditions ne vous accordent aucun droit de copier, modifier, distribuer ou procéder à l’ingénierie inverse de l’application, sauf lorsque la loi l’autorise.',
      },
      {
        heading: '8. Disponibilité et changements',
        body:
          'Carful peut évoluer avec le temps, et certaines fonctions peuvent dépendre de plateformes mobiles, services backend, accès réseau ou fournisseurs tiers. Le service peut être interrompu, modifié ou arrêté.',
      },
      {
        heading: '9. Responsabilité',
        body:
          'Dans la mesure permise par la loi, Carful est fourni sans garanties de disponibilité ininterrompue, exactitude, adéquation à un usage particulier ou fonctionnement sans erreur. Rien dans ces conditions ne limite la responsabilité lorsqu’elle ne peut pas être légalement limitée, y compris faute intentionnelle ou droits impératifs des consommateurs.',
      },
      {
        heading: '10. Contexte applicable',
        body:
          'Ces conditions sont prévues pour l’exploitation de Carful par un éditeur individuel en Allemagne. Les droits impératifs des consommateurs et le droit applicable restent inchangés.',
      },
    ],
  },
}

export default defineI18nLocale(() => fr)
