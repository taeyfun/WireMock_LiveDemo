# Studierendenprofil · Hochschule Nordtal

## Ursprünglicher Prompt

> Du bist ein unglaublicher Senior Frontend Engineer und Softwarearchitekt. Für dieses Projekt möchte ich, dass du für mich eine Profilverwaltungsseite für Studierende einer fiktiven Hochschule erstellst. Ziel ist es, dass die Studierenden auf dieser Seite ihre persönlichen Angaben verwalten und alles auf einen Blick übersichtlich haben können. Die Seite sollte diese Funktionen unbedingt erfüllen: Profilansicht für Studierende, persönliche Angaben, studienbezogene Informationen, Bearbeiten und Speichern von Profildaten, moderne und nutzbare Benutzeroberfläche. Zu den verbindlichen Technologiestacks gehören Vue.js 3, TypeScript, Vite und CSS. Teile die Anwendung sinnvoll auf, erstelle dabei eine Hauptkomponente (Vue-App) und separate Child-Komponenten für die persönlichen Daten und studienbezogenen Daten. Ich möchte ein modernes Design mit heller Ansicht, welche durch dunkelblaue Akzente verschönert wird, da die Farbe Dunkelblau die Hochschule insgesamt dekoriert. Es soll alles intuitiv gestaltet sein, jedoch trotzdem modern bleiben und auch simpel, aber nicht zu simpel. Die Seite soll über ein Menü die Möglichkeit geben, direkt auf andere Seiten zugreifen zu können, wie z. B. Stundenplan, Noten oder Kommunikation. Beschränke dich hierbei aber wirklich auf die Profilverwaltungsseite. Als Ergebnis erwarte ich von dir eine lauffähige Vue-App im Repository. Verwende bitte die vorhandenen Frontend-Design-Skills im Repository. Erstelle mir übrigens auch noch eine readme Datei, wo du den Prompt erhältst und kurz beschreibst, was du generiert hast und wie man am Ende auf die Seite zugreifen kann.

## Was erstellt wurde

Eine responsive Profilverwaltungsseite für die fiktive Hochschule Nordtal. Die Hauptansicht zeigt Studierendenidentität, Matrikelnummer und Studienstatus. Persönliche Angaben und Studieninformationen sind in separaten Vue-Komponenten organisiert. Profildaten lassen sich bearbeiten, speichern und abbrechen; gespeicherte Änderungen bleiben in diesem Browser über `localStorage` erhalten. Die Campusnavigation zeigt Stundenplan, Noten und Kommunikation als weitere Bereiche, während die Profilseite den Umfang der Anwendung bildet.

Die Oberfläche verwendet Vue 3, TypeScript, Vite und CSS. Sie ist für Tastaturbedienung und kleine Displays ausgelegt.

## Starten

Voraussetzung ist eine aktuelle Node.js-Version. Im Repository-Verzeichnis ausführen:

```sh
npm install
npm run dev
```

Vite zeigt anschließend die lokale Adresse an (standardmäßig <http://localhost:5173>). Für einen Produktionsbuild:

```sh
npm run build
npm run preview
```
