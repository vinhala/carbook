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
import { en } from '~/locales/en'
import { APP_STORE_URL, PLAY_STORE_URL } from '~/utils/storeLinks'

const featureIcons = [ClipboardCheck, CalendarClock, Wrench, FileText]
</script>

<template>
  <div>
    <AppHeader />

    <main>
      <section class="hero-section">
        <div class="hero-copy">
          <p class="eyebrow">{{ en.landing.hero.eyebrow }}</p>
          <h1>{{ en.landing.hero.title }}</h1>
          <p class="hero-body">{{ en.landing.hero.body }}</p>
          <StoreButtons :app-store-url="APP_STORE_URL" :play-store-url="PLAY_STORE_URL" />
        </div>

        <div class="hero-visual">
          <AppMockup />
        </div>
      </section>

      <section id="features" class="feature-section">
        <div class="section-heading">
          <p class="eyebrow">Carful advantages</p>
          <h2>{{ en.landing.featuresHeading }}</h2>
          <p>{{ en.landing.featuresBody }}</p>
        </div>

        <div class="feature-grid">
          <article v-for="(feature, index) in en.landing.features" :key="feature.title" class="feature-card">
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
            {{ en.landing.ai.eyebrow }}
          </p>
          <h2>{{ en.landing.ai.title }}</h2>
          <p>{{ en.landing.ai.body }}</p>
        </div>

        <div class="chat-card" aria-label="AI assistant preview">
          <div class="chat-row chat-row--user">
            <span class="chat-avatar" aria-hidden="true">You</span>
            <p>{{ en.landing.ai.question }}</p>
          </div>
          <div class="chat-row chat-row--assistant">
            <span class="chat-avatar chat-avatar--assistant" aria-hidden="true">
              <Bot :size="18" />
            </span>
            <p>{{ en.landing.ai.answer }}</p>
          </div>
        </div>
      </section>

      <section id="vehicle-history" class="value-section">
        <div class="value-icon" aria-hidden="true">
          <History :size="34" />
        </div>
        <h2>{{ en.landing.value.title }}</h2>
        <p>{{ en.landing.value.body }}</p>
        <div class="trust-row" aria-label="Carful trust points">
          <span><ShieldCheck :size="18" aria-hidden="true" /> Local-first records</span>
          <span><FileText :size="18" aria-hidden="true" /> Manual-aware AI</span>
          <span><Wrench :size="18" aria-hidden="true" /> Built for DIY work</span>
        </div>
      </section>
    </main>

    <AppFooter />
  </div>
</template>
