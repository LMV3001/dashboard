<script setup lang="ts">
import { computed, reactive, ref, watch } from 'vue'

const product = reactive({
  quantity: 0,
  price: 10,
  name: 't-shirt',
})

const text = ref('')

const prixTotalHt = computed(() => product.quantity * product.price)
const prixTotalTtc = computed(() => prixTotalHt.value * 1.2)

watch([prixTotalHt, prixTotalTtc], ([newHt, newTtc], [oldHt, oldTtc]) => {
  text.value = 'les données ont changé'
})
</script>

<template>
  <header>
    <nav></nav>
    <input type="number" v-model="product.quantity" />
    <input type="number" v-model="product.price" />
    <h1>prix total ht :{{ prixTotalHt }}</h1>
    <h1>prix total ttc :{{ prixTotalTtc }}</h1>
    <p>{{ text }}</p>
  </header>
</template>

<style scoped></style>
