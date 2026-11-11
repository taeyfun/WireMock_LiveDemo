<script setup lang="ts">
import { computed, onMounted, ref } from 'vue'
import PersonalData from './components/PersonalData.vue'
import StudyData from './components/StudyData.vue'
import WeatherCard from './components/WeatherCard.vue'
import type { StudentProfile } from './types'

const defaults: StudentProfile = {
  firstName: 'Mila', lastName: 'Schneider', email: 'mila.schneider@stud.hsnordtal.de', phone: '+49 151 2345 6789',
  birthDate: '2002-04-18', address: 'Musterstraße 24', postalCity: '10115 Berlin', studentId: '2024 018 672',
  degree: 'B. Sc. Medieninformatik', faculty: 'Fachbereich Informatik', semester: '4. Fachsemester', startTerm: 'Wintersemester 2024', studyStatus: 'Aktiv',
}
const profile = ref<StudentProfile>({ ...defaults })
const editing = ref(false)
const saved = ref(false)
const menuOpen = ref(false)
const fullName = computed(() => `${profile.value.firstName} ${profile.value.lastName}`.trim())

onMounted(() => {
  try {
    const stored = localStorage.getItem('nordtal-student-profile')
    if (stored) {
      const savedProfile = JSON.parse(stored) as Partial<StudentProfile>
      if (savedProfile.postalCity?.toLowerCase().includes('kiel')) {
        savedProfile.address = defaults.address
        savedProfile.postalCity = defaults.postalCity
      }
      profile.value = { ...defaults, ...savedProfile }
    }
  } catch { localStorage.removeItem('nordtal-student-profile') }
})
function startEditing() { editing.value = true; saved.value = false }
function saveProfile() {
  localStorage.setItem('nordtal-student-profile', JSON.stringify(profile.value))
  editing.value = false
  saved.value = true
  window.setTimeout(() => { saved.value = false }, 3500)
}
function cancelEditing() {
  try {
    const stored = localStorage.getItem('nordtal-student-profile')
    profile.value = stored ? { ...defaults, ...JSON.parse(stored) as Partial<StudentProfile> } : { ...defaults }
  } catch { profile.value = { ...defaults } }
  editing.value = false
}
</script>

<template>
  <div class="app-shell">
    <aside class="sidebar" :class="{ 'sidebar-open': menuOpen }">
      <a class="brand" href="#profil" aria-label="Hochschule Nordtal – Startseite">
        <span class="brand-mark"><svg viewBox="0 0 40 40" aria-hidden="true"><path d="M7 29V11l13 18V11M27 11v18h7"/></svg></span>
        <span class="brand-name">HOCHSCHULE <strong>NORDTAL</strong></span>
      </a>
      <div class="nav-caption">CAMPUS</div>
      <nav class="main-nav" aria-label="Hauptnavigation">
        <a class="nav-link" href="#stundenplan" @click.prevent><svg viewBox="0 0 24 24"><rect x="3.5" y="5" width="17" height="16" rx="2"/><path d="M8 3v4m8-4v4M4 10h16M8 14h.01M12 14h.01M16 14h.01M8 17.5h.01M12 17.5h.01"/></svg><span>Stundenplan</span></a>
        <a class="nav-link" href="#noten" @click.prevent><svg viewBox="0 0 24 24"><path d="M5 3.5h14v17l-7-4-7 4z"/><path d="m9 10 2 2 4-4"/></svg><span>Noten</span></a>
        <a class="nav-link" href="#kommunikation" @click.prevent><svg viewBox="0 0 24 24"><path d="M4 5.5h16v12H9l-5 3z"/><path d="M8 10h8M8 13.5h5"/></svg><span>Kommunikation</span><span class="nav-count">2</span></a>
        <a class="nav-link active" href="#profil" aria-current="page"><svg viewBox="0 0 24 24"><circle cx="12" cy="8" r="3.5"/><path d="M5.5 20v-1.5a6.5 6.5 0 0 1 13 0V20z"/></svg><span>Mein Profil</span></a>
      </nav>
      <div class="sidebar-bottom">
        <div class="semester-note"><span class="semester-dot"></span><span>Wintersemester 2026/27</span></div>
        <div class="help-link"><span class="help-mark">?</span><span>Hilfe &amp; Support</span></div>
      </div>
    </aside>

    <main class="main-area" id="profil">
      <header class="topbar">
        <button class="mobile-menu" type="button" aria-label="Menü öffnen" :aria-expanded="menuOpen" @click="menuOpen = !menuOpen"><span></span><span></span><span></span></button>
        <div class="breadcrumbs"><span>Mein Campus</span><span class="crumb-divider">/</span><strong>Mein Profil</strong></div>
        <div class="topbar-right"><button class="icon-button notification-button" type="button" aria-label="Benachrichtigungen"><svg viewBox="0 0 24 24"><path d="M18 9a6 6 0 0 0-12 0c0 7-3 7-3 9h18c0-2-3-2-3-9M10 21h4"/></svg><i></i></button><span class="top-divider"></span><div class="user-mini"><div class="mini-avatar">MS</div><span>{{ fullName }}</span><svg class="chevron" viewBox="0 0 24 24"><path d="m7 10 5 5 5-5"/></svg></div></div>
      </header>

      <div class="page-content">
        <section class="profile-intro" aria-labelledby="page-title">
          <div class="intro-copy"><div class="eyebrow"><span class="eyebrow-rule"></span>Dein Campus, dein Überblick</div><h1 id="page-title">Mein Profil</h1><p>Hier findest du deine persönlichen und studienbezogenen Angaben.</p></div>
          <div class="intro-actions">
            <span v-if="saved" class="save-feedback" role="status"><svg viewBox="0 0 20 20"><path d="m4 10 4 4 8-8"/></svg>Änderungen gespeichert</span>
            <template v-if="editing"><button class="button button-quiet" type="button" @click="cancelEditing">Abbrechen</button><button class="button button-primary" type="button" @click="saveProfile"><svg viewBox="0 0 20 20"><path d="M4 3.5h10l2 2v11H4zM7 3.5v5h6v-5M7 16.5v-5h6v5"/></svg>Speichern</button></template>
            <button v-else class="button button-primary" type="button" @click="startEditing"><svg viewBox="0 0 20 20"><path d="m12.8 4.2 3 3M4 16l3.2-.7L16 6.5a1.8 1.8 0 0 0-2.5-2.5l-8.8 8.8L4 16Z"/></svg>Profil bearbeiten</button>
          </div>
        </section>

        <section class="identity-strip" aria-label="Studierendenübersicht">
          <div class="identity-main"><div class="avatar">{{ profile.firstName.charAt(0) }}{{ profile.lastName.charAt(0) }}</div><div class="identity-text"><h2>{{ fullName }}</h2><p>{{ profile.degree }} <span class="identity-separator">/</span> {{ profile.semester }}</p></div></div>
          <div class="identity-meta"><div class="meta-item"><span class="meta-label">Matrikelnummer</span><strong>{{ profile.studentId }}</strong></div><span class="meta-divider"></span><div class="meta-item"><span class="meta-label">Studienstatus</span><span class="status-pill"><span></span>{{ profile.studyStatus }}</span></div></div>
        </section>

        <div v-if="editing" class="edit-notice" role="status"><svg viewBox="0 0 20 20"><circle cx="10" cy="10" r="7.5"/><path d="M10 9v4m0-6h.01"/></svg>Du bearbeitest dein Profil. Änderungen werden erst nach dem Speichern übernommen.</div>

        <div class="profile-grid">
          <PersonalData v-model="profile" :editing="editing" />
          <StudyData v-model="profile" :editing="editing" />
        </div>

        <WeatherCard />

        <footer class="page-footer"><span>Fragen zu deinen Daten? <a href="mailto:studierendenservice@hsnordtal.de">Der Studierendenservice hilft dir gern.</a></span><span>Deine Daten werden vertraulich behandelt.</span></footer>
      </div>
    </main>
    <button v-if="menuOpen" class="sidebar-scrim" type="button" aria-label="Menü schließen" @click="menuOpen = false"></button>
  </div>
</template>
