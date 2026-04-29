<script setup lang="ts">
import { APP_STORE_URL, PLAY_STORE_URL } from '~/utils/storeLinks'

const { t } = useI18n()
const localePath = useLocalePath()
</script>

<template>
  <footer class="site-footer">
    <div class="footer-shell">
      <div class="footer-brand">
        <NuxtLink class="footer-logo" :to="localePath('/')">
          <span class="brand-icon footer-logo-icon" aria-hidden="true">
            <img src="/brand/carful-logo.png" alt="" />
          </span>
          <span>{{ t('brand.name') }}</span>
        </NuxtLink>
        <p>{{ t('brand.tagline') }}</p>
        <a :href="`mailto:${t('brand.contactEmail')}`">{{ t('brand.contactEmail') }}</a>
      </div>

      <nav class="footer-links" :aria-label="t('navigation.footer')">
        <NuxtLink :to="localePath('/privacy')">{{ t('navigation.privacy') }}</NuxtLink>
        <NuxtLink :to="localePath('/terms')">{{ t('navigation.terms') }}</NuxtLink>
        <a :href="APP_STORE_URL">{{ t('store.appStore') }}</a>
        <a :href="PLAY_STORE_URL">{{ t('store.playStore') }}</a>
      </nav>
    </div>
  </footer>
</template>
