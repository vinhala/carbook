import type { LocaleMessages } from './en'

const pl: LocaleMessages = {
  meta: {
    title: 'Carful - Cyfrowy garaż dla majsterkowiczów',
    description:
      'Carful pomaga osobom samodzielnie dbającym o auta śledzić obsługę, naprawy, modyfikacje, instrukcje warsztatowe i wiedzę wspieraną przez AI.',
  },
  brand: {
    name: 'Carful',
    tagline: 'Zaprojektowany na długą trasę.',
    contactEmail: 'contact@carful.diy',
    publisher: 'Vincent Halasz',
    country: 'Niemcy',
  },
  navigation: {
    primary: 'Nawigacja główna',
    footer: 'Nawigacja w stopce',
    toggle: 'Przełącz nawigację',
    home: 'Strona główna Carful',
    backHome: 'Wróć do Carful',
    features: 'Funkcje',
    ai: 'Asystent AI',
    value: 'Historia pojazdu',
    privacy: 'Prywatność',
    terms: 'Warunki',
  },
  language: {
    label: 'Język',
  },
  store: {
    appStore: 'App Store',
    playStore: 'Google Play',
    appStoreAria: 'Pobierz Carful z App Store',
    playStoreAria: 'Pobierz Carful z Google Play',
  },
  landing: {
    hero: {
      eyebrow: 'Cyfrowy garaż dla majsterkowiczów',
      title: 'Trzymaj każdą pracę, część i interwał serwisowy w jednym spokojnym miejscu.',
      body:
        'Carful pomaga organizować profile pojazdów, śledzić obsługę, dokumentować naprawy i modyfikacje, trzymać instrukcje warsztatowe pod ręką i zadawać asystentowi AI pytania o auto, przy którym pracujesz.',
    },
    mockup: {
      aria: 'Podgląd aplikacji Carful',
      activeProfile: 'Aktywny profil',
      vehicle: 'BMW 328i 1998',
      engine: 'M52B28 - 142 380 km',
      warning: 'Obsługa po terminie',
      warningDetail: 'Płyn hamulcowy - 24 dni po terminie',
      health: 'Gotowość garażu',
      healthValue: '88%',
      repairTitle: 'Odświeżenie przedniego zawieszenia',
      repairMeta: 'Planowana naprawa - wysoka pilność',
      logTitle: 'Olej i filtr',
      logMeta: 'Ukończono - 141 900 km',
    },
    featureEyebrow: 'Zalety Carful',
    featuresHeading: 'Stworzone do pracy, która utrzymuje auto przy życiu.',
    featuresBody:
      'Niezależnie od tego, czy dbasz o codzienne auto, czy planujesz weekendowy projekt, Carful sprawia, że szczegóły są łatwe do znalezienia, gdy ręce masz już zajęte.',
    features: [
      {
        title: 'Profile pojazdów, które pamiętają szczegóły',
        body:
          'Zapisuj markę, model, silnik, pierwszą rejestrację, VIN, aktualny przebieg, jednostki, zdjęcia i preferencje przypomnień dla każdego auta, o które dbasz.',
      },
      {
        title: 'Harmonogramy obsługi bez zgadywania',
        body:
          'Śledź powtarzalne prace według przebiegu lub czasu, zapisuj wykonany serwis i sprawdzaj opóźnienia, zanim drobne zaniedbanie stanie się kosztowne.',
      },
      {
        title: 'Rejestry napraw i modyfikacji',
        body:
          'Planuj przyszłe prace z pilnością, częściami, plikami i zdjęciami, a po zakończeniu zamieniaj je w historię wykonanych działań.',
      },
      {
        title: 'Instrukcje warsztatowe pod ręką',
        body:
          'Dołączaj instrukcje do profilu pojazdu, aby zaufane informacje były powiązane z dokładnie tym autem, którego dotyczą.',
      },
    ],
    ai: {
      eyebrow: 'Wiedza garażowa wspierana przez AI',
      title: 'Zadawaj pytania w kontekście swojego prawdziwego auta.',
      body:
        'Carful może używać profilu, harmonogramu obsługi, historii napraw i instrukcji warsztatowych, aby tworzyć zadania i odpowiadać na pytania dotyczące konkretnego pojazdu. Ma wspierać uważną pracę, a nie zastępować profesjonalną ocenę.',
      previewAria: 'Podgląd asystenta AI',
      user: 'Ty',
      question: 'Co sprawdzić przed wymianą pompy wody?',
      answer:
        'Zacznij od procedury z instrukcji serwisowej, sprawdź przebieg paska, stan płynu chłodniczego, powierzchnie uszczelki, kolejność dokręcania i przewody, do których masz dostęp przy otwartym przodzie silnika.',
    },
    value: {
      title: 'Dobrze udokumentowanemu autu łatwiej zaufać.',
      body:
        'Czytelne zapisy ułatwiają obsługę, pomagają zaplanować części przed rozpoczęciem pracy i tworzą użyteczną historię do diagnostyki lub rozmów przy sprzedaży.',
      trustAria: 'Punkty zaufania Carful',
      trust: ['Najpierw lokalne zapisy', 'AI świadome instrukcji', 'Stworzone do pracy DIY'],
    },
  },
  legal: {
    updated: 'Ostatnia aktualizacja: 28 kwietnia 2026',
    privacyTitle: 'Polityka prywatności',
    termsTitle: 'Warunki korzystania',
    privacy: [
      {
        heading: '1. Administrator',
        body:
          'Administratorem odpowiedzialnym za Carful jest {publisher}, {country}. W sprawach prywatności i RODO możesz skontaktować się pod adresem {email}.',
      },
      {
        heading: '2. Co przetwarza Carful',
        body:
          'Carful jest zaprojektowany jako lokalny towarzysz pojazdu. W zależności od użycia aplikacja może przetwarzać dane profilu pojazdu, przebieg, jednostki odległości, VIN, informacje o silniku, zdjęcia, harmonogramy obsługi, dzienniki obsługi, rejestry napraw i modyfikacji, części, linki, załączniki, instrukcje warsztatowe, zapytania i odpowiedzi asystenta AI oraz dane techniczne potrzebne do działania usług backend.',
      },
      {
        heading: '3. Przechowywanie lokalne i funkcje backend',
        body:
          'Podstawowe zapisy pojazdu są przechowywane na urządzeniu. Funkcje korzystające z przetwarzania instrukcji, sugestii obsługi lub asystenta AI mogą wysyłać do usług backend Carful odpowiedni kontekst pojazdu, pliki lub metadane instrukcji, pozycje obsługi, streszczenia napraw i Twoje wiadomości, aby dana funkcja mogła działać.',
      },
      {
        heading: '4. AI i zewnętrzni przetwarzający',
        body:
          'Funkcje AI mogą być przetwarzane przez OpenAI lub równoważnych dostawców infrastruktury AI. Usługi te mogą otrzymywać treści potrzebne do odpowiedzi, takie jak zapytanie, kontekst profilu pojazdu, streszczenia historii napraw, pozycje obsługi i treści instrukcji. Nie przesyłaj przez funkcje AI informacji, których nie chcesz przetwarzać w tym celu.',
      },
      {
        heading: '5. Podstawy prawne',
        body:
          'Carful przetwarza dane w celu dostarczenia aplikacji i żądanych funkcji na podstawie wykonania umowy, obsługi i ochrony usługi na podstawie uzasadnionych interesów, wypełnienia obowiązków prawnych oraz, gdy wymagane, na podstawie zgody. Zgodę można wycofać, gdy przetwarzanie się na niej opiera.',
      },
      {
        heading: '6. Retencja',
        body:
          'Lokalne zapisy pozostają na urządzeniu, dopóki ich nie usuniesz lub nie odinstalujesz aplikacji. Rekordy backend, przesłane instrukcje, metadane rozmów asystenta i logi techniczne są przechowywane tylko tak długo, jak potrzeba do świadczenia usługi, rozwiązywania problemów, ochrony usługi lub spełnienia obowiązków prawnych. Usunięcia możesz zażądać pod adresem {email}.',
      },
      {
        heading: '7. Twoje prawa RODO',
        body:
          'Gdy ma zastosowanie RODO, możesz żądać dostępu, sprostowania, usunięcia, ograniczenia przetwarzania, przenoszenia danych lub sprzeciwić się przetwarzaniu. Możesz też wycofać zgodę, gdy dotyczy, i złożyć skargę do organu ochrony danych.',
      },
      {
        heading: '8. Transfery międzynarodowe',
        body:
          'Niektórzy dostawcy backend lub AI mogą przetwarzać dane poza Europejskim Obszarem Gospodarczym. W takich przypadkach Carful opiera się na odpowiednich zabezpieczeniach, takich jak ochrona umowna lub inne prawnie uznane mechanizmy transferu.',
      },
      {
        heading: '9. Dzieci',
        body:
          'Carful jest przeznaczony dla osób, które utrzymują lub dokumentują pojazdy. Nie jest kierowany do dzieci; dzieci nie powinny korzystać z aplikacji bez odpowiedniego udziału rodzica lub opiekuna.',
      },
      {
        heading: '10. Zmiany',
        body:
          'Ta polityka może być aktualizowana wraz z rozwojem Carful. Istotne aktualizacje będą odzwierciedlane na tej stronie.',
      },
    ],
    terms: [
      {
        heading: '1. Dostawca',
        body:
          'Carful jest dostarczany przez {publisher}, {country}. W sprawach wsparcia, prywatności lub prawnych skontaktuj się z {email}.',
      },
      {
        heading: '2. Co robi Carful',
        body:
          'Carful pomaga użytkownikom organizować profile pojazdów, przebieg, harmonogramy obsługi, naprawy, modyfikacje, instrukcje warsztatowe i pytania o pojazdy wspierane przez AI. Aplikacja jest narzędziem dokumentacji i planowania. Nie wykonuje napraw i nie gwarantuje bezpieczeństwa, zdatności do ruchu, wartości ani zgodności prawnej pojazdu.',
      },
      {
        heading: '3. Twoja odpowiedzialność',
        body:
          'Odpowiadasz za dokładność wprowadzonych informacji i decyzje podejmowane podczas obsługi, naprawy, modyfikacji, jazdy, sprzedaży lub kontroli pojazdu. Zawsze stosuj dokumentację producenta, odpowiednie narzędzia i środki bezpieczeństwa oraz konsultuj wykwalifikowanego specjalistę, gdy zadanie może wpływać na bezpieczeństwo lub legalność.',
      },
      {
        heading: '4. Ograniczenia asystenta AI',
        body:
          'Odpowiedzi generowane przez AI mogą być niepełne, nieaktualne lub błędne. Wyniki AI służą wyłącznie wygodzie i planowaniu. Nie stanowią profesjonalnej porady mechanicznej, technicznej, bezpieczeństwa, prawnej ani inspekcyjnej. Przed działaniem weryfikuj ważne informacje w instrukcjach, zaleceniach producenta i u wykwalifikowanych specjalistów.',
      },
      {
        heading: '5. Dozwolone użycie',
        body:
          'Nie używaj Carful do przesyłania treści bezprawnych, naruszania praw osób trzecich, nadużywania backendu, obchodzenia limitów lub zabezpieczeń ani proszenia o instrukcje dotyczące niebezpiecznej lub bezprawnej aktywności pojazdowej. Dostęp może być ograniczony lub odmówiony, jeśli użycie zagraża usłudze lub innym.',
      },
      {
        heading: '6. Twoje treści',
        body:
          'Zachowujesz własność zapisów pojazdu, zdjęć, instrukcji, plików i wiadomości dodanych do Carful. Udzielasz Carful ograniczonego pozwolenia potrzebnego do przechowywania, przetwarzania, przesyłania i wyświetlania tych treści, aby aplikacja i żądane funkcje backend lub AI mogły działać.',
      },
      {
        heading: '7. Własność intelektualna',
        body:
          'Nazwa Carful, projekt aplikacji, oprogramowanie i powiązane materiały są chronione prawami własności intelektualnej. Warunki nie dają praw do kopiowania, modyfikowania, dystrybucji ani inżynierii wstecznej aplikacji, poza przypadkami dozwolonymi przez prawo.',
      },
      {
        heading: '8. Dostępność i zmiany',
        body:
          'Carful może zmieniać się z czasem, a niektóre funkcje mogą zależeć od platform mobilnych, usług backend, dostępu do sieci lub dostawców zewnętrznych. Usługa może być przerwana, zmieniona lub zakończona.',
      },
      {
        heading: '9. Odpowiedzialność',
        body:
          'W zakresie dozwolonym przez prawo Carful jest dostarczany bez gwarancji nieprzerwanej dostępności, dokładności, przydatności do określonego celu lub działania bez błędów. Nic w tych warunkach nie ogranicza odpowiedzialności tam, gdzie nie można jej prawnie ograniczyć, w tym za działanie umyślne lub obowiązkowe prawa konsumentów.',
      },
      {
        heading: '10. Kontekst prawny',
        body:
          'Warunki są przeznaczone dla działania Carful przez indywidualnego wydawcę w Niemczech. Obowiązkowe prawa konsumentów i właściwe prawo pozostają nienaruszone.',
      },
    ],
  },
}

export default defineI18nLocale(() => pl)
