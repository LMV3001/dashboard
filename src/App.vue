<script setup lang="ts">
import { computed, reactive, ref, watch } from 'vue'
import NavComposant from './Nav_composant.vue'
import ListePieces from './Liste_pieces.vue'
import './assets/base.css'

interface User {
  name: string
  email?: string
}

const user = reactive<User>({
  name: '',
})

const ongoing = ref(true)
const onfocus = ref(false)
const touched = ref(false)
const onerror = computed(() => user.name.length < 5 && !onfocus.value && touched.value)
const onvalid = computed(() => user.name.length >= 5)
const product = reactive({
  quantity: 0,
  price: 10,
  name: 't-shirt',
})

const text = ref('')

const prixTotalHt = computed(() => product.quantity * product.price)
const prixTotalTtc = computed(() => prixTotalHt.value * 1.2)

watch([prixTotalHt, prixTotalTtc], ([newHt, newTtc], [oldHt, oldTtc]) => {
  text.value = `les données ont changé : ht=${oldHt} -> ${newHt}, ttc=${oldTtc} -> ${newTtc}`
})
</script>

<template>
  <header>
    <nav>
      <NavComposant />
    </nav>
  </header>

  <div class="listePieces">
    <ListePieces />
  </div>
  <input
    :class="{ ongoing, onfocus, onerror, onvalid }"
    type="text"
    v-model="user.name"
    @focus="((onfocus = true), (touched = true))"
    @blur="onfocus = false"
  />
  <span>entrer votre nom</span>
  <input type="number" v-model="product.quantity" />
  <input type="number" v-model="product.price" />
  <h1>prix total ht :{{ prixTotalHt }}</h1>
  <h1>prix total ttc :{{ prixTotalTtc }}</h1>

  <p>{{ text }}</p>
</template>

<style scoped>
template {
  background: var(--color-background);
}
.ongoing {
  outline: 0;
  border: 1px solid black;
}

.onfocus {
  border-color: blue;
}

.onvalid {
  border-color: green;
}

.onerror {
  border-color: red;
}
</style>
