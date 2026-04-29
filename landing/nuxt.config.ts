export default defineNuxtConfig({
  compatibilityDate: '2025-01-15',
  css: ['~/assets/css/main.css'],
  devtools: { enabled: true },
  modules: ['@nuxtjs/i18n'],
  i18n: {
    defaultLocale: 'en',
    strategy: 'prefix_except_default',
    langDir: '../locales',
    detectBrowserLanguage: {
      useCookie: true,
      cookieKey: 'carful_locale',
      redirectOn: 'root',
      alwaysRedirect: false,
      fallbackLocale: 'en',
    },
    locales: [
      { code: 'en', name: 'English', language: 'en-US', file: 'en.ts' },
      { code: 'de', name: 'Deutsch', language: 'de-DE', file: 'de.ts' },
      { code: 'es', name: 'Español', language: 'es-ES', file: 'es.ts' },
      { code: 'fr', name: 'Français', language: 'fr-FR', file: 'fr.ts' },
      { code: 'it', name: 'Italiano', language: 'it-IT', file: 'it.ts' },
      { code: 'pl', name: 'Polski', language: 'pl-PL', file: 'pl.ts' },
    ],
  },
  app: {
    head: {
      title: 'Carful - The digital garage for DIY car owners',
      htmlAttrs: {
        lang: 'en',
      },
      meta: [
        { charset: 'utf-8' },
        { name: 'viewport', content: 'width=device-width, initial-scale=1' },
        {
          name: 'description',
          content:
            'Carful helps DIY car owners track maintenance, repairs, modifications, workshop manuals, and AI-assisted vehicle knowledge.',
        },
        { name: 'theme-color', content: '#50604d' },
      ],
      link: [
        { rel: 'icon', type: 'image/png', href: '/favicon.png' },
        { rel: 'apple-touch-icon', href: '/apple-touch-icon.png' },
        { rel: 'preconnect', href: 'https://fonts.googleapis.com' },
        { rel: 'preconnect', href: 'https://fonts.gstatic.com', crossorigin: '' },
        {
          rel: 'stylesheet',
          href: 'https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap',
        },
      ],
    },
  },
})
