<script setup lang="ts">
import type { StudentProfile } from '../types'

const props = defineProps<{ modelValue: StudentProfile; editing: boolean }>()
const emit = defineEmits<{ 'update:modelValue': [value: StudentProfile] }>()

function update(key: keyof StudentProfile, value: string) {
  const current = { ...props.modelValue, [key]: value }
  emit('update:modelValue', current)
}
</script>

<template>
  <section class="profile-card" aria-labelledby="personal-heading">
    <div class="card-heading">
      <div class="heading-icon" aria-hidden="true">
        <svg viewBox="0 0 24 24"><circle cx="12" cy="8" r="3.5"/><path d="M5.5 20v-1.5a6.5 6.5 0 0 1 13 0V20z"/></svg>
      </div>
      <div><h2 id="personal-heading">Persönliche Angaben</h2><p>So erreichen wir dich</p></div>
    </div>
    <div class="fields-grid">
      <label class="field"><span>Vorname</span><input :value="modelValue.firstName" :readonly="!editing" @input="update('firstName', ($event.target as HTMLInputElement).value)" /></label>
      <label class="field"><span>Nachname</span><input :value="modelValue.lastName" :readonly="!editing" @input="update('lastName', ($event.target as HTMLInputElement).value)" /></label>
      <label class="field"><span>E-Mail-Adresse</span><input type="email" :value="modelValue.email" :readonly="!editing" @input="update('email', ($event.target as HTMLInputElement).value)" /></label>
      <label class="field"><span>Telefon</span><input type="tel" :value="modelValue.phone" :readonly="!editing" @input="update('phone', ($event.target as HTMLInputElement).value)" /></label>
      <label class="field"><span>Geburtsdatum</span><input type="date" :value="modelValue.birthDate" :readonly="!editing" @input="update('birthDate', ($event.target as HTMLInputElement).value)" /></label>
      <label class="field"><span>Straße und Hausnummer</span><input :value="modelValue.address" :readonly="!editing" @input="update('address', ($event.target as HTMLInputElement).value)" /></label>
      <label class="field field-wide"><span>PLZ und Wohnort</span><input :value="modelValue.postalCity" :readonly="!editing" @input="update('postalCity', ($event.target as HTMLInputElement).value)" /></label>
    </div>
  </section>
</template>
