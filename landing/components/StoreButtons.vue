<script setup lang="ts">
import { Apple, Play } from 'lucide-vue-next'

defineProps<{
  appStoreUrl: string
  playStoreUrl: string
  compact?: boolean
}>()

const { t } = useI18n()
</script>

<template>
  <div class="store-buttons" :class="{ 'store-buttons--compact': compact }">
    <a class="store-button store-button--primary" :href="appStoreUrl" :aria-label="t('store.appStoreAria')">
      <Apple :size="compact ? 18 : 22" aria-hidden="true" />
      <span>{{ t('store.appStore') }}</span>
    </a>
    <a class="store-button store-button--secondary" :href="playStoreUrl" :aria-label="t('store.playStoreAria')">
      <Play :size="compact ? 18 : 22" aria-hidden="true" />
      <span>{{ t('store.playStore') }}</span>
    </a>
  </div>
</template>
