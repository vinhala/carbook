import type { LocaleMessages } from './en'

const it: LocaleMessages = {
  meta: {
    title: 'Carful - Il garage digitale per proprietari DIY',
    description:
      'Carful aiuta chi cura la propria auto a tenere traccia di manutenzione, riparazioni, modifiche, manuali d’officina e conoscenza assistita dall’IA.',
  },
  brand: {
    name: 'Carful',
    tagline: 'Progettato per durare.',
    contactEmail: 'contact@carful.diy',
    publisher: 'Vincent Halasz',
    country: 'Germania',
  },
  navigation: {
    primary: 'Navigazione principale',
    footer: 'Navigazione footer',
    toggle: 'Apri o chiudi navigazione',
    home: 'Home Carful',
    backHome: 'Torna a Carful',
    features: 'Funzioni',
    ai: 'Assistente IA',
    value: 'Storico veicolo',
    privacy: 'Privacy',
    terms: 'Termini',
  },
  language: {
    label: 'Lingua',
  },
  store: {
    appStore: 'App Store',
    playStore: 'Google Play',
    appStoreAria: 'Scarica Carful su App Store',
    playStoreAria: 'Ottieni Carful su Google Play',
  },
  landing: {
    hero: {
      eyebrow: 'Garage digitale per proprietari DIY',
      title: 'Tieni ogni lavoro, pezzo e intervallo di servizio in un posto tranquillo.',
      body:
        'Carful ti aiuta a organizzare profili veicolo, seguire la manutenzione, documentare riparazioni e modifiche, tenere vicini i manuali d’officina e fare domande a un assistente IA sull’auto su cui stai lavorando.',
    },
    mockup: {
      aria: 'Anteprima dell’app Carful',
      activeProfile: 'Profilo attivo',
      vehicle: 'BMW 328i 1998',
      engine: 'M52B28 - 142.380 km',
      warning: 'Manutenzione scaduta',
      warningDetail: 'Liquido freni - 24 giorni di ritardo',
      health: 'Prontezza del garage',
      healthValue: '88%',
      repairTitle: 'Aggiornamento sospensione anteriore',
      repairMeta: 'Riparazione pianificata - urgenza alta',
      logTitle: 'Olio e filtro',
      logMeta: 'Completato - 141.900 km',
    },
    featureEyebrow: 'Vantaggi Carful',
    featuresHeading: 'Creato per il lavoro che tiene viva un’auto.',
    featuresBody:
      'Che tu stia preservando un’auto quotidiana o pianificando un progetto del weekend, Carful mantiene i dettagli facili da trovare quando hai già le mani occupate.',
    features: [
      {
        title: 'Profili veicolo che ricordano i dettagli',
        body:
          'Salva marca, modello, motore, prima immatricolazione, VIN, chilometraggio attuale, unità, foto e preferenze dei promemoria per ogni auto a cui tieni.',
      },
      {
        title: 'Piani di manutenzione senza supposizioni',
        body:
          'Segui lavori ricorrenti per distanza o tempo, registra i servizi completati e vedi cosa è scaduto prima che una piccola dimenticanza diventi costosa.',
      },
      {
        title: 'Registri di riparazioni e modifiche',
        body:
          'Pianifica lavori futuri con urgenza, parti, file e immagini, poi trasformali in storico completato quando il lavoro è finito.',
      },
      {
        title: 'Manuali d’officina sempre a portata',
        body:
          'Allega i manuali a un profilo veicolo così le informazioni affidabili restano organizzate con l’auto esatta a cui appartengono.',
      },
    ],
    ai: {
      eyebrow: 'Conoscenza di garage assistita dall’IA',
      title: 'Fai domande nel contesto della tua auto reale.',
      body:
        'Carful può usare profilo, piano di manutenzione, storico riparazioni e manuali d’officina per generare attività e rispondere a domande specifiche del veicolo. È pensato per supportare un lavoro accurato, non per sostituire il giudizio professionale.',
      previewAria: 'Anteprima assistente IA',
      user: 'Tu',
      question: 'Cosa devo controllare prima di sostituire la pompa dell’acqua?',
      answer:
        'Parti dalla procedura del manuale, controlla percorso cinghia, stato del refrigerante, superfici di tenuta, sequenza di serraggio e i tubi raggiungibili mentre la parte anteriore del motore è aperta.',
    },
    value: {
      title: 'Un’auto ben documentata è più facile da fidarsi.',
      body:
        'Registri chiari rendono la manutenzione più semplice, aiutano a pianificare i ricambi prima di iniziare e creano uno storico utile per diagnosi future o vendita.',
      trustAria: 'Punti di fiducia Carful',
      trust: ['Registri prima locali', 'IA consapevole dei manuali', 'Costruito per il lavoro DIY'],
    },
  },
  legal: {
    updated: 'Ultimo aggiornamento: 28 aprile 2026',
    privacyTitle: 'Informativa sulla privacy',
    termsTitle: 'Termini di servizio',
    privacy: [
      {
        heading: '1. Titolare',
        body:
          'Il titolare responsabile di Carful è {publisher}, {country}. Puoi contattarlo per richieste privacy e GDPR a {email}.',
      },
      {
        heading: '2. Cosa tratta Carful',
        body:
          'Carful è progettato come compagno veicolo local-first. A seconda dell’uso, può trattare dettagli del profilo veicolo, chilometraggio, unità di distanza, VIN, informazioni motore, foto, piani e registri di manutenzione, registri di riparazioni e modifiche, parti, link, allegati, manuali d’officina, prompt e risposte dell’assistente IA e dati tecnici necessari ai servizi backend.',
      },
      {
        heading: '3. Archiviazione locale e funzioni backend',
        body:
          'I registri principali del veicolo sono salvati sul dispositivo. Le funzioni che usano elaborazione dei manuali, suggerimenti di manutenzione o assistente IA possono inviare ai servizi backend di Carful contesto veicolo, file o metadati dei manuali, attività di manutenzione, riepiloghi di riparazione e messaggi, così la funzione richiesta può funzionare.',
      },
      {
        heading: '4. IA e fornitori terzi',
        body:
          'Le funzioni IA possono essere elaborate da OpenAI o fornitori equivalenti di infrastruttura IA. Questi servizi possono ricevere il contenuto necessario per rispondere alla richiesta, come prompt, contesto profilo veicolo, riepiloghi riparazioni, elementi di manutenzione e contenuto dei manuali. Non inviare tramite funzioni IA informazioni che non vuoi siano trattate per questo scopo.',
      },
      {
        heading: '5. Basi giuridiche',
        body:
          'Carful tratta dati per fornire app e funzioni richieste in esecuzione contrattuale, per gestire e proteggere il servizio in base a interessi legittimi, per adempiere obblighi legali e, quando richiesto, in base al consenso. Puoi revocare il consenso quando il trattamento dipende da esso.',
      },
      {
        heading: '6. Conservazione',
        body:
          'I registri locali restano sul dispositivo finché li elimini o rimuovi l’app. Registri backend, manuali caricati, metadati conversazioni assistente e log tecnici sono conservati solo per il tempo necessario a fornire il servizio, risolvere problemi, proteggere il servizio o rispettare obblighi legali. Puoi chiedere la cancellazione a {email}.',
      },
      {
        heading: '7. I tuoi diritti GDPR',
        body:
          'Quando si applica il GDPR, puoi chiedere accesso, rettifica, cancellazione, limitazione del trattamento, portabilità dei dati o opporti al trattamento. Puoi anche revocare il consenso dove applicabile e presentare reclamo a un’autorità di protezione dati.',
      },
      {
        heading: '8. Trasferimenti internazionali',
        body:
          'Alcuni fornitori backend o IA possono trattare dati fuori dallo Spazio Economico Europeo. In questi casi Carful si affida a garanzie adeguate come protezioni contrattuali o altri meccanismi di trasferimento riconosciuti dalla legge.',
      },
      {
        heading: '9. Minori',
        body:
          'Carful è destinato a persone che mantengono o documentano veicoli. Non è rivolto ai minori, che non dovrebbero usare l’app senza adeguato coinvolgimento di un genitore o tutore.',
      },
      {
        heading: '10. Modifiche',
        body:
          'Questa informativa può essere aggiornata man mano che Carful evolve. Gli aggiornamenti rilevanti saranno riflessi in questa pagina.',
      },
    ],
    terms: [
      {
        heading: '1. Fornitore',
        body:
          'Carful è fornito da {publisher}, {country}. Per supporto, privacy o questioni legali, contatta {email}.',
      },
      {
        heading: '2. Cosa fa Carful',
        body:
          'Carful aiuta gli utenti a organizzare profili veicolo, chilometraggio, piani di manutenzione, riparazioni, modifiche, manuali d’officina e domande veicolo assistite dall’IA. L’app è uno strumento di documentazione e pianificazione. Non esegue riparazioni e non garantisce sicurezza, idoneità alla circolazione, valore o conformità legale del veicolo.',
      },
      {
        heading: '3. La tua responsabilità',
        body:
          'Sei responsabile dell’accuratezza delle informazioni inserite e delle decisioni prese durante manutenzione, riparazione, modifica, guida, vendita o ispezione di un veicolo. Segui sempre la documentazione del costruttore, usa strumenti e dispositivi di sicurezza adeguati e consulta un professionista qualificato quando un’attività può incidere su sicurezza o legalità.',
      },
      {
        heading: '4. Limiti dell’assistente IA',
        body:
          'Le risposte generate dall’IA possono essere incomplete, obsolete o errate. L’output IA è fornito solo per comodità e supporto alla pianificazione. Non è consulenza professionale meccanica, tecnica, di sicurezza, legale o ispettiva. Verifica le informazioni importanti con manuali, indicazioni del costruttore e professionisti qualificati prima di agire.',
      },
      {
        heading: '5. Uso accettabile',
        body:
          'Non usare Carful per inviare contenuti illeciti, violare diritti di terzi, abusare del backend, aggirare limiti o controlli di sicurezza o richiedere istruzioni per attività veicolari insicure o illegali. L’accesso può essere limitato o rifiutato se l’uso rischia di danneggiare il servizio o altri.',
      },
      {
        heading: '6. I tuoi contenuti',
        body:
          'Mantieni la proprietà dei registri veicolo, foto, manuali, file e messaggi che aggiungi a Carful. Concedi a Carful il permesso limitato necessario per archiviare, trattare, trasmettere e mostrare tali contenuti affinché l’app e le funzioni backend o IA richieste possano funzionare.',
      },
      {
        heading: '7. Proprietà intellettuale',
        body:
          'Il nome Carful, il design dell’app, il software e i materiali collegati sono protetti dalle leggi sulla proprietà intellettuale. Questi termini non concedono diritti di copiare, modificare, distribuire o effettuare reverse engineering dell’app salvo quanto consentito dalla legge.',
      },
      {
        heading: '8. Disponibilità e modifiche',
        body:
          'Carful può cambiare nel tempo e alcune funzioni possono dipendere da piattaforme mobili, servizi backend, accesso di rete o fornitori terzi. Il servizio può essere interrotto, modificato o dismesso.',
      },
      {
        heading: '9. Responsabilità',
        body:
          'Nei limiti consentiti dalla legge, Carful è fornito senza garanzie di disponibilità ininterrotta, accuratezza, idoneità a uno scopo particolare o funzionamento privo di errori. Nulla in questi termini limita la responsabilità dove non può essere legalmente limitata, inclusi dolo o diritti obbligatori dei consumatori.',
      },
      {
        heading: '10. Contesto applicabile',
        body:
          'Questi termini sono pensati per la gestione di Carful da parte di un editore individuale in Germania. I diritti obbligatori dei consumatori e la legge applicabile restano invariati.',
      },
    ],
  },
}

export default defineI18nLocale(() => it)
