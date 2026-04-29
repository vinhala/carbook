<script setup lang="ts">
import {
  Bot,
  CalendarClock,
  ClipboardCheck,
  FileText,
  History,
  ShieldCheck,
  Sparkles,
  Wrench,
} from 'lucide-vue-next'
import { APP_STORE_URL, PLAY_STORE_URL } from '~/utils/storeLinks'

const featureIcons = [ClipboardCheck, CalendarClock, Wrench, FileText]
const { t, tm } = useI18n()

type Feature = {
  title: string
  body: string
}

const features = computed(() => tm('landing.features') as Feature[])
const trustItems = computed(() => tm('landing.value.trust') as string[])
</script>

<template>
  <div>
    <AppHeader />

    <main>
      <section class="hero-section">
        <div class="hero-copy">
          <p class="eyebrow">{{ t('landing.hero.eyebrow') }}</p>
          <h1>{{ t('landing.hero.title') }}</h1>
          <p class="hero-body">{{ t('landing.hero.body') }}</p>
          <StoreButtons :app-store-url="APP_STORE_URL" :play-store-url="PLAY_STORE_URL" />
        </div>

        <div class="hero-visual">
          <AppMockup />
        </div>
      </section>

      <section id="features" class="feature-section">
        <div class="section-heading">
          <p class="eyebrow">{{ t('landing.featureEyebrow') }}</p>
          <h2>{{ t('landing.featuresHeading') }}</h2>
          <p>{{ t('landing.featuresBody') }}</p>
        </div>

        <div class="feature-grid">
          <article v-for="(feature, index) in features" :key="feature.title" class="feature-card">
            <span class="feature-icon" aria-hidden="true">
              <component :is="featureIcons[index]" :size="26" />
            </span>
            <h3>{{ feature.title }}</h3>
            <p>{{ feature.body }}</p>
          </article>
        </div>
      </section>

      <section id="ai-assistant" class="ai-section">
        <div class="ai-copy">
          <p class="inverse-eyebrow">
            <Sparkles :size="16" aria-hidden="true" />
            {{ t('landing.ai.eyebrow') }}
          </p>
          <h2>{{ t('landing.ai.title') }}</h2>
          <p>{{ t('landing.ai.body') }}</p>
        </div>

        <div class="chat-card" :aria-label="t('landing.ai.previewAria')">
          <div class="chat-row chat-row--user">
            <span class="chat-avatar" aria-hidden="true">{{ t('landing.ai.user') }}</span>
            <p>{{ t('landing.ai.question') }}</p>
          </div>
          <div class="chat-row chat-row--assistant">
            <span class="chat-avatar chat-avatar--assistant" aria-hidden="true">
              <Bot :size="18" />
            </span>
            <p>{{ t('landing.ai.answer') }}</p>
          </div>
        </div>
      </section>

      <section id="vehicle-history" class="value-section">
        <div class="value-icon" aria-hidden="true">
          <History :size="34" />
        </div>
        <h2>{{ t('landing.value.title') }}</h2>
        <p>{{ t('landing.value.body') }}</p>
        <div class="trust-row" :aria-label="t('landing.value.trustAria')">
          <span><ShieldCheck :size="18" aria-hidden="true" /> {{ trustItems[0] }}</span>
          <span><FileText :size="18" aria-hidden="true" /> {{ trustItems[1] }}</span>
          <span><Wrench :size="18" aria-hidden="true" /> {{ trustItems[2] }}</span>
        </div>
      </section>
    </main>

    <AppFooter />
  </div>
</template>
