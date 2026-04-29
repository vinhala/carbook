<script setup lang="ts">
type LegalSection = {
  heading: string
  body: string
}

const { t, tm } = useI18n()

const sections = computed(() => tm('legal.terms') as LegalSection[])
const email = computed(() => t('brand.contactEmail'))

function bodyParts(body: string) {
  const interpolated = body
    .replaceAll('{publisher}', t('brand.publisher'))
    .replaceAll('{country}', t('brand.country'))
  const [beforeEmail, afterEmail = ''] = interpolated.split('{email}')
  return { beforeEmail, afterEmail }
}
</script>

<template>
  <div>
    <AppHeader />
    <LegalPage :title="t('legal.termsTitle')" :updated="t('legal.updated')">
      <article v-for="section in sections" :key="section.heading">
        <h2>{{ section.heading }}</h2>
        <p>
          {{ bodyParts(section.body).beforeEmail
          }}<a v-if="section.body.includes('{email}')" :href="`mailto:${email}`">{{ email }}</a
          >{{ bodyParts(section.body).afterEmail }}
        </p>
      </article>
    </LegalPage>
    <AppFooter />
  </div>
</template>
