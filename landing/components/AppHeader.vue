<script setup lang="ts">
import { Menu, Wrench, X } from 'lucide-vue-next'
import { en } from '~/locales/en'
import { APP_STORE_URL, PLAY_STORE_URL } from '~/utils/storeLinks'

const open = ref(false)

const navItems = [
  { label: en.navigation.features, href: '/#features' },
  { label: en.navigation.ai, href: '/#ai-assistant' },
  { label: en.navigation.value, href: '/#vehicle-history' },
]
</script>

<template>
  <header class="site-header">
    <div class="nav-shell">
      <NuxtLink class="brand-mark" to="/" aria-label="Carful home">
        <span class="brand-icon" aria-hidden="true">
          <Wrench :size="20" stroke-width="2.4" />
        </span>
        <span>{{ en.brand.name }}</span>
      </NuxtLink>

      <nav class="desktop-nav" aria-label="Primary navigation">
        <a v-for="item in navItems" :key="item.href" :href="item.href">{{ item.label }}</a>
      </nav>

      <div class="desktop-actions">
        <StoreButtons compact :app-store-url="APP_STORE_URL" :play-store-url="PLAY_STORE_URL" />
      </div>

      <button
        class="icon-button mobile-menu-button"
        type="button"
        :aria-expanded="open"
        aria-controls="mobile-menu"
        aria-label="Toggle navigation"
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
      <StoreButtons :app-store-url="APP_STORE_URL" :play-store-url="PLAY_STORE_URL" />
    </div>
  </header>
</template>
