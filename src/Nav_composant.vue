<template>
  <div class="container">
    <ul>
      <li>Tout</li>
      <li>Chauffage</li>
      <li>Eclairage</li>
      <li>Sécurité</li>
    </ul>
  </div>
</template>
<script lang="ts" setup>
import './assets/base.css'
</script>
<style scoped lang="scss">
.container {
  width: 80%;
  height: 50px;
  background: var(--color-primary);
  margin: auto;
  border: 1px solid black;
  border-radius: 50px;
  list-style: none;
  display: flex;
  align-items: center;
  ul {
    display: flex;
    justify-content: space-around;
    align-items: center;
    width: 100%;
    border: 1px solid blue;
    list-style: none;
    gap: 20px;
    padding: 0;
    margin: 0;
    li {
      border: 1px solid red;
      font-size: 20px;
      color: var(--color-text);
    }
  }
}
</style>
