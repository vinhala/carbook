<script setup lang="ts">
import { en } from '~/locales/en'
</script>

<template>
  <div>
    <AppHeader />
    <LegalPage :title="en.legal.termsTitle" :updated="en.legal.updated">
      <h2>1. Provider</h2>
      <p>
        Carful is provided by {{ en.brand.publisher }}, {{ en.brand.country }}. For support, privacy,
        or legal questions, contact
        <a :href="`mailto:${en.brand.contactEmail}`">{{ en.brand.contactEmail }}</a>.
      </p>

      <h2>2. What Carful does</h2>
      <p>
        Carful helps users organize vehicle profiles, mileage, maintenance schedules, repairs,
        modifications, workshop manuals, and AI-assisted vehicle questions. The app is a documentation
        and planning tool. It does not perform repairs and does not guarantee a vehicle's safety,
        roadworthiness, value, or legal compliance.
      </p>

      <h2>3. Your responsibility</h2>
      <p>
        You are responsible for the accuracy of the information you enter and for the decisions you make
        while maintaining, repairing, modifying, driving, selling, or inspecting a vehicle. Always follow
        the vehicle manufacturer's documentation, use appropriate tools and safety equipment, and consult
        a qualified professional when a task may affect safety or legality.
      </p>

      <h2>4. AI assistant limitations</h2>
      <p>
        AI-generated answers may be incomplete, outdated, or incorrect. AI output is provided for
        convenience and planning support only. It is not professional mechanical, engineering, safety,
        legal, or inspection advice. Verify important information against workshop manuals, manufacturer
        guidance, and qualified professionals before acting on it.
      </p>

      <h2>5. Acceptable use</h2>
      <p>
        Do not use Carful to submit unlawful content, infringe third-party rights, abuse the backend,
        bypass rate limits or security controls, or request instructions for unsafe or unlawful vehicle
        activity. Access may be limited or refused if use risks harm to the service or others.
      </p>

      <h2>6. Your content</h2>
      <p>
        You keep ownership of the vehicle records, photos, manuals, files, and messages you add to Carful.
        You grant Carful the limited permission needed to store, process, transmit, and display that content
        so the app and requested backend or AI features can operate.
      </p>

      <h2>7. Intellectual property</h2>
      <p>
        The Carful name, app design, software, and related materials are protected by intellectual property
        laws. These terms do not grant you rights to copy, modify, distribute, or reverse engineer the app
        except where allowed by law.
      </p>

      <h2>8. Availability and changes</h2>
      <p>
        Carful may change over time, and some features may depend on mobile platforms, backend services,
        network access, or third-party providers. The service may be interrupted, changed, or discontinued.
      </p>

      <h2>9. Liability</h2>
      <p>
        To the extent permitted by law, Carful is provided without warranties of uninterrupted availability,
        accuracy, fitness for a particular purpose, or error-free operation. Nothing in these terms limits
        liability where it cannot legally be limited, including intentional misconduct or mandatory consumer
        rights.
      </p>

      <h2>10. Governing context</h2>
      <p>
        These terms are intended for the operation of Carful by an individual publisher in Germany. Mandatory
        consumer protection rights and applicable law remain unaffected.
      </p>
    </LegalPage>
    <AppFooter />
  </div>
</template>
