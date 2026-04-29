<script setup lang="ts">
import { Menu, X } from 'lucide-vue-next'
import { APP_STORE_URL, PLAY_STORE_URL } from '~/utils/storeLinks'

const open = ref(false)
const { t, locale, locales } = useI18n()
const localePath = useLocalePath()
const switchLocalePath = useSwitchLocalePath()

const navItems = computed(() => [
  { label: t('navigation.features'), href: `${localePath('/')}#features` },
  { label: t('navigation.ai'), href: `${localePath('/')}#ai-assistant` },
  { label: t('navigation.value'), href: `${localePath('/')}#vehicle-history` },
])

const localeOptions = computed(() =>
  locales.value.map((item) => (typeof item === 'string' ? { code: item, name: item } : item)),
)
</script>

<template>
  <header class="site-header">
    <div class="nav-shell">
      <NuxtLink class="brand-mark" :to="localePath('/')" :aria-label="t('navigation.home')">
        <span class="brand-icon" aria-hidden="true">
          <img src="/brand/carful-logo.png" alt="" />
        </span>
        <span>{{ t('brand.name') }}</span>
      </NuxtLink>

      <nav class="desktop-nav" :aria-label="t('navigation.primary')">
        <a v-for="item in navItems" :key="item.href" :href="item.href">{{ item.label }}</a>
      </nav>

      <div class="desktop-actions">
        <div class="language-switcher" :aria-label="t('language.label')">
          <NuxtLink
            v-for="item in localeOptions"
            :key="item.code"
            :to="switchLocalePath(item.code)"
            :class="{ active: item.code === locale }"
          >
            {{ item.code.toUpperCase() }}
          </NuxtLink>
        </div>
        <StoreButtons compact :app-store-url="APP_STORE_URL" :play-store-url="PLAY_STORE_URL" />
      </div>

      <button
        class="icon-button mobile-menu-button"
        type="button"
        :aria-expanded="open"
        aria-controls="mobile-menu"
        :aria-label="t('navigation.toggle')"
        @click="open = !open"
      >
        <X v-if="open" :size="22" />
        <Menu v-else :size="22" />
      </button>
    </div>

    <div v-if="open" id="mobile-menu" class="mobile-menu">
      <a v-for="item in navItems" :key="item.href" :href="item.href" @click="open = false">
        {{ item.label }}
      </a>
      <div class="language-switcher language-switcher--mobile" :aria-label="t('language.label')">
        <NuxtLink
          v-for="item in localeOptions"
          :key="item.code"
          :to="switchLocalePath(item.code)"
          :class="{ active: item.code === locale }"
          @click="open = false"
        >
          {{ item.code.toUpperCase() }}
        </NuxtLink>
      </div>
      <StoreButtons :app-store-url="APP_STORE_URL" :play-store-url="PLAY_STORE_URL" />
    </div>
  </header>
</template>
