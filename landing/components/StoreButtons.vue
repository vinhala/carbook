<script setup lang="ts">
import { Apple, Play } from 'lucide-vue-next'
import { en } from '~/locales/en'

defineProps<{
  appStoreUrl: string
  playStoreUrl: string
  compact?: boolean
}>()
</script>

<template>
  <div class="store-buttons" :class="{ 'store-buttons--compact': compact }">
    <a class="store-button store-button--primary" :href="appStoreUrl" :aria-label="en.store.appStoreAria">
      <Apple :size="compact ? 18 : 22" aria-hidden="true" />
      <span>{{ en.store.appStore }}</span>
    </a>
    <a class="store-button store-button--secondary" :href="playStoreUrl" :aria-label="en.store.playStoreAria">
      <Play :size="compact ? 18 : 22" aria-hidden="true" />
      <span>{{ en.store.playStore }}</span>
    </a>
  </div>
</template>
