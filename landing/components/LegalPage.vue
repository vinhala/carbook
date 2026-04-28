<script setup lang="ts">
defineProps<{
  title: string
  updated: string
}>()
</script>

<template>
  <main class="legal-page">
    <section class="legal-hero">
      <NuxtLink class="back-link" to="/">Back to Carful</NuxtLink>
      <p>{{ updated }}</p>
      <h1>{{ title }}</h1>
    </section>
    <section class="legal-content">
      <slot />
    </section>
  </main>
</template>
