export default defineNuxtConfig({
  compatibilityDate: '2025-01-15',
  css: ['~/assets/css/main.css'],
  devtools: { enabled: true },
  modules: [],
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
