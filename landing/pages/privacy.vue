<script setup lang="ts">
import { en } from '~/locales/en'
</script>

<template>
  <div>
    <AppHeader />
    <LegalPage :title="en.legal.privacyTitle" :updated="en.legal.updated">
      <h2>1. Controller</h2>
      <p>
        The controller responsible for Carful is {{ en.brand.publisher }}, {{ en.brand.country }}.
        You can contact the controller for privacy and GDPR requests at
        <a :href="`mailto:${en.brand.contactEmail}`">{{ en.brand.contactEmail }}</a>.
      </p>

      <h2>2. What Carful processes</h2>
      <p>
        Carful is designed as a local-first vehicle companion. Depending on how you use the app, it may
        process vehicle profile details, mileage, distance units, VIN, engine information, photos,
        maintenance schedules, maintenance logs, repair and modification records, parts, links,
        attachments, workshop manuals, AI assistant prompts and responses, and technical data needed to
        operate the backend services.
      </p>

      <h2>3. Local storage and backend features</h2>
      <p>
        Core vehicle records are stored on your device. Features that use workshop manual processing,
        maintenance schedule suggestions, or the AI assistant may send relevant vehicle context,
        manual files or metadata, maintenance items, repair summaries, and your messages to Carful's
        backend so the requested feature can work.
      </p>

      <h2>4. AI and third-party processors</h2>
      <p>
        AI features may be processed by OpenAI or equivalent AI infrastructure providers. These services
        may receive the content needed to answer your request, such as your prompt, vehicle profile
        context, repair history summaries, maintenance items, and workshop manual content. Do not submit
        information through AI features that you do not want processed for this purpose.
      </p>

      <h2>5. Legal bases</h2>
      <p>
        Carful processes data to provide the app and requested features under contract performance,
        to operate and protect the service under legitimate interests, to comply with legal obligations,
        and, where required, based on your consent. You may withdraw consent where processing depends on it.
      </p>

      <h2>6. Retention</h2>
      <p>
        Local records remain on your device until you delete them or remove the app. Backend records,
        uploaded manuals, assistant conversation metadata, and technical logs are retained only as long
        as needed to provide the service, troubleshoot, protect the service, or meet legal obligations.
        You can request deletion by contacting
        <a :href="`mailto:${en.brand.contactEmail}`">{{ en.brand.contactEmail }}</a>.
      </p>

      <h2>7. Your GDPR rights</h2>
      <p>
        Where the GDPR applies, you may request access, rectification, erasure, restriction of processing,
        data portability, or object to processing. You may also withdraw consent where applicable and lodge
        a complaint with a data protection supervisory authority.
      </p>

      <h2>8. International transfers</h2>
      <p>
        Some backend or AI providers may process data outside the European Economic Area. Where this occurs,
        Carful relies on appropriate safeguards such as contractual protections or other legally recognized
        transfer mechanisms.
      </p>

      <h2>9. Children</h2>
      <p>
        Carful is intended for people who maintain or document vehicles. It is not directed to children,
        and children should not use the app without appropriate parental or guardian involvement.
      </p>

      <h2>10. Changes</h2>
      <p>
        This policy may be updated as Carful evolves. Material updates will be reflected on this page.
      </p>
    </LegalPage>
    <AppFooter />
  </div>
</template>
