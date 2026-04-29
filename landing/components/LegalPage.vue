<script setup lang="ts">
defineProps<{
  title: string
  updated: string
}>()

const { t } = useI18n()
const localePath = useLocalePath()
</script>

<template>
  <main class="legal-page">
    <section class="legal-hero">
      <NuxtLink class="back-link" :to="localePath('/')">{{ t('navigation.backHome') }}</NuxtLink>
      <p>{{ updated }}</p>
      <h1>{{ title }}</h1>
    </section>
    <section class="legal-content">
      <slot />
    </section>
  </main>
</template>
