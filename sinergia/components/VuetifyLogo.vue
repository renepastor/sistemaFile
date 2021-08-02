<template>
  <img
    class="VuetifyLogo"
    alt="Vuetify Logo"
    src="/logo.png"
  >
</template>

<style>
.VuetifyLogo {
  height: 120px;
  width: 220px;
  transform: rotateY(560deg);
  animation: turn 3.5s ease-out forwards 1s;
}

@keyframes turn {
  100% {
    transform: rotateY(0deg);
  }
}
</style>
