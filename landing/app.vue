<script setup lang="ts">
const { locale, t } = useI18n()

useHead(() => ({
  title: t('meta.title'),
  htmlAttrs: {
    lang: locale.value,
  },
  meta: [
    {
      name: 'description',
      content: t('meta.description'),
    },
  ],
}))
</script>

<template>
  <NuxtLayout>
    <NuxtPage />
  </NuxtLayout>
</template>
