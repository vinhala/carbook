<script setup lang="ts">
import { en } from '~/locales/en'
import { APP_STORE_URL, PLAY_STORE_URL } from '~/utils/storeLinks'
</script>

<template>
  <footer class="site-footer">
    <div class="footer-shell">
      <div class="footer-brand">
        <NuxtLink class="footer-logo" to="/">{{ en.brand.name }}</NuxtLink>
        <p>{{ en.brand.tagline }}</p>
        <a :href="`mailto:${en.brand.contactEmail}`">{{ en.brand.contactEmail }}</a>
      </div>

      <nav class="footer-links" aria-label="Footer navigation">
        <NuxtLink to="/privacy">{{ en.navigation.privacy }}</NuxtLink>
        <NuxtLink to="/terms">{{ en.navigation.terms }}</NuxtLink>
        <a :href="APP_STORE_URL">{{ en.store.appStore }}</a>
        <a :href="PLAY_STORE_URL">{{ en.store.playStore }}</a>
      </nav>
    </div>
  </footer>
</template>
