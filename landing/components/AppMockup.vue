<script setup lang="ts">
import { AlertTriangle, CheckCircle2, Gauge, Wrench } from 'lucide-vue-next'
import { en } from '~/locales/en'
</script>

<template>
  <div class="phone-visual" aria-label="Carful app preview">
    <div class="phone-header">
      <div>
        <p class="phone-kicker">Active profile</p>
        <h2>{{ en.landing.mockup.vehicle }}</h2>
        <p>{{ en.landing.mockup.engine }}</p>
      </div>
      <div class="avatar-plate" aria-hidden="true">328</div>
    </div>

    <div class="alert-card">
      <AlertTriangle :size="24" aria-hidden="true" />
      <div>
        <strong>{{ en.landing.mockup.warning }}</strong>
        <span>{{ en.landing.mockup.warningDetail }}</span>
      </div>
    </div>

    <div class="metric-card">
      <div>
        <span>{{ en.landing.mockup.health }}</span>
        <strong>{{ en.landing.mockup.healthValue }}</strong>
      </div>
      <div class="progress-ring" aria-hidden="true">
        <Gauge :size="28" />
      </div>
    </div>

    <div class="work-list">
      <div class="work-item">
        <span class="work-icon work-icon--warning" aria-hidden="true">
          <Wrench :size="20" />
        </span>
        <div>
          <strong>{{ en.landing.mockup.repairTitle }}</strong>
          <span>{{ en.landing.mockup.repairMeta }}</span>
        </div>
      </div>
      <div class="work-item">
        <span class="work-icon work-icon--done" aria-hidden="true">
          <CheckCircle2 :size="20" />
        </span>
        <div>
          <strong>{{ en.landing.mockup.logTitle }}</strong>
          <span>{{ en.landing.mockup.logMeta }}</span>
        </div>
      </div>
    </div>
  </div>
</template>
