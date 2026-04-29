<script setup lang="ts">
import { AlertTriangle, CheckCircle2, Gauge, Wrench } from 'lucide-vue-next'

const { t } = useI18n()
</script>

<template>
  <div class="phone-visual" :aria-label="t('landing.mockup.aria')">
    <div class="phone-header">
      <div>
        <p class="phone-kicker">{{ t('landing.mockup.activeProfile') }}</p>
        <h2>{{ t('landing.mockup.vehicle') }}</h2>
        <p>{{ t('landing.mockup.engine') }}</p>
      </div>
      <div class="avatar-plate" aria-hidden="true">328</div>
    </div>

    <div class="alert-card">
      <AlertTriangle :size="24" aria-hidden="true" />
      <div>
        <strong>{{ t('landing.mockup.warning') }}</strong>
        <span>{{ t('landing.mockup.warningDetail') }}</span>
      </div>
    </div>

    <div class="metric-card">
      <div>
        <span>{{ t('landing.mockup.health') }}</span>
        <strong>{{ t('landing.mockup.healthValue') }}</strong>
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
          <strong>{{ t('landing.mockup.repairTitle') }}</strong>
          <span>{{ t('landing.mockup.repairMeta') }}</span>
        </div>
      </div>
      <div class="work-item">
        <span class="work-icon work-icon--done" aria-hidden="true">
          <CheckCircle2 :size="20" />
        </span>
        <div>
          <strong>{{ t('landing.mockup.logTitle') }}</strong>
          <span>{{ t('landing.mockup.logMeta') }}</span>
        </div>
      </div>
    </div>
  </div>
</template>
