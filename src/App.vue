<script setup lang="ts">
const objet = {
  class: 'maclass',
  id: 'monid',
}

const name = 'michel'

function userClick() {
  console.log('click')
}
</script>

<template>
  <header>
    <nav></nav>
    <h1 @click="userClick" v-bind="objet">hello world {{ name }}</h1>
  </header>
</template>

<style scoped></style>
