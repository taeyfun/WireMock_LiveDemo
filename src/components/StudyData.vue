<script setup lang="ts">
import type { StudentProfile } from '../types'

const props = defineProps<{ modelValue: StudentProfile; editing: boolean }>()
const emit = defineEmits<{ 'update:modelValue': [value: StudentProfile] }>()
function update(key: keyof StudentProfile, value: string) {
  emit('update:modelValue', { ...props.modelValue, [key]: value })
}
</script>

<template>
  <section class="profile-card study-card" aria-labelledby="study-heading">
    <div class="card-heading">
      <div class="heading-icon study-icon" aria-hidden="true">
        <svg viewBox="0 0 24 24"><path d="m3 9 9-5 9 5-9 5-9-5Z"/><path d="M7 11.2v5.1c2.8 2.3 7.2 2.3 10 0v-5.1M21 9v6"/></svg>
      </div>
      <div><h2 id="study-heading">Studienbezogene Daten</h2><p>Dein aktueller Studienstand</p></div>
    </div>
    <div class="fields-grid">
      <label class="field field-wide"><span>Studiengang</span><input :value="modelValue.degree" :readonly="!editing" @input="update('degree', ($event.target as HTMLInputElement).value)" /></label>
      <label class="field"><span>Fachbereich</span><input :value="modelValue.faculty" :readonly="!editing" @input="update('faculty', ($event.target as HTMLInputElement).value)" /></label>
      <label class="field"><span>Fachsemester</span><input :value="modelValue.semester" :readonly="!editing" @input="update('semester', ($event.target as HTMLInputElement).value)" /></label>
      <label class="field"><span>Studienbeginn</span><input :value="modelValue.startTerm" :readonly="!editing" @input="update('startTerm', ($event.target as HTMLInputElement).value)" /></label>
      <label class="field"><span>Status</span>
        <select :value="modelValue.studyStatus" :disabled="!editing" @change="update('studyStatus', ($event.target as HTMLSelectElement).value)">
          <option>Aktiv</option><option>Beurlaubt</option><option>Abgeschlossen</option>
        </select>
      </label>
    </div>
    <div class="student-number"><span>Matrikelnummer</span><strong>{{ modelValue.studentId }}</strong><span class="number-lock" title="Nicht bearbeitbar" aria-label="Nicht bearbeitbar">⌑</span></div>
  </section>
</template>
