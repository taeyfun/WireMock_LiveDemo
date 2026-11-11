<script setup lang="ts">
import { onMounted, ref } from 'vue'

type ForecastDay = {
  date: string
  label: string
  condition: 'cloudy' | 'rain' | 'sun' | 'partly-cloudy'
  description: string
  high: number
  low: number
  rainChance: number
}
type Weather = { location: string; current: ForecastDay & { temperature: number }; forecast: ForecastDay[] }

const weather = ref<Weather | null>(null)
const error = ref(false)
const loading = ref(true)
const iconPaths: Record<ForecastDay['condition'], string> = {
  cloudy: 'M7 18h10a4 4 0 0 0 .4-8A6 6 0 0 0 6 11a3.5 3.5 0 0 0 1 7Z',
  rain: 'M7 14h10a4 4 0 0 0 .4-8A6 6 0 0 0 6 7a3.5 3.5 0 0 0 1 7Zm1 3-1 2m6-2-1 2m6-2-1 2',
  sun: 'M12 7a5 5 0 1 0 0 10 5 5 0 0 0 0-10ZM12 2v2m0 16v2M4.9 4.9l1.4 1.4m11.4 11.4 1.4 1.4M2 12h2m16 0h2M4.9 19.1l1.4-1.4M17.7 6.3l1.4-1.4',
  'partly-cloudy': 'M12 4V2m6.4 4.6 1.4-1.4M21 12h-2M5 12H3m3.1-5.4L4.7 5.2M9 18h9a3.5 3.5 0 0 0 .2-7A5.5 5.5 0 0 0 8 12a3 3 0 0 0 1 6Z',
}

onMounted(async () => {
  try {
    const base = (import.meta.env.VITE_WEATHER_API_URL || '').replace(/\/$/, '')
    const response = await fetch(`${base}/api/weather?city=Berlin`)
    if (!response.ok) throw new Error('Wetterdaten nicht verfügbar')
    weather.value = await response.json() as Weather
  } catch {
    error.value = true
  } finally {
    loading.value = false
  }
})
</script>

<template>
  <section class="weather-card" aria-labelledby="weather-title">
    <header class="weather-header">
      <div><div class="weather-kicker">Dein Wetterüberblick</div><h2 id="weather-title">Wetter in {{ weather?.location || 'Berlin' }}</h2></div>
      <span class="weather-date">Freitag, 13. November 2026</span>
    </header>
    <p v-if="loading" class="weather-message" role="status">Wetterdaten werden geladen …</p>
    <p v-else-if="error" class="weather-message" role="status">Wetterdaten sind gerade nicht erreichbar. Bitte versuche es später erneut.</p>
    <template v-else-if="weather">
      <div class="weather-current">
        <svg class="weather-current-icon" viewBox="0 0 24 24" aria-hidden="true"><path :d="iconPaths[weather.current.condition]" /></svg>
        <div class="weather-current-temp">{{ weather.current.temperature }}°</div>
        <div class="weather-current-copy"><strong>{{ weather.current.description }}</strong><span>Heute · Höchstwert {{ weather.current.high }}° / Tiefstwert {{ weather.current.low }}°</span></div>
        <div class="weather-rain"><span aria-hidden="true">☂</span><strong>{{ weather.current.rainChance }}%</strong><small>Regen</small></div>
      </div>
      <div class="forecast-list" aria-label="Wettervorhersage für die nächsten fünf Tage">
        <article v-for="day in weather.forecast" :key="day.date" class="forecast-day">
          <div class="forecast-date"><strong>{{ day.label }}</strong><span>{{ day.date }}</span></div>
          <svg class="forecast-icon" :class="`condition-${day.condition}`" viewBox="0 0 24 24" role="img" :aria-label="day.description"><path :d="iconPaths[day.condition]" /></svg>
          <span class="forecast-description">{{ day.description }}</span>
          <div class="forecast-temperatures"><strong>{{ day.high }}°</strong><span>{{ day.low }}°</span></div>
          <div class="forecast-rain"><span aria-hidden="true">☂</span>{{ day.rainChance }}%</div>
        </article>
      </div>
      <div class="weather-source">Wetter-Simulation · Daten bereitgestellt über WireMock</div>
    </template>
  </section>
</template>
