<template>
  <div class="container" ref="containerRef">
    <span class="navette" :style="navette"></span>
    <ul>
      <li
        v-for="(item, index) in items"
        :key="item"
        :ref="(el) => setItemRef(el, index)"
        :class="{ active: activeIndex === index }"
        @click="setActiveIndex(index)"
      >
        {{ item }}
      </li>
    </ul>
  </div>
</template>
<script lang="ts" setup>
import { nextTick, onBeforeUnmount, onMounted, ref } from 'vue'
import './assets/base.css'

const items = ['Tout', 'Chauffage', 'Eclairage', 'Sécurité']
const activeIndex = ref(0)
const containerRef = ref<HTMLElement | null>(null)
// On garde des refs directes vers chaque li pour éviter querySelector à chaque resize.
const itemRefs = ref<HTMLElement[]>([])
// Style inline réactif utilisé par l'élément de fond qui glisse.
const navette = ref({
  height: '0px',
  width: '0px',
  left: '0px',
  top: '0px',
  opacity: '0',
})
let resizeObserver: ResizeObserver | null = null
let resizeRaf = 0

function setItemRef(el: Element | null, index: number) {
  if (el instanceof HTMLElement) {
    itemRefs.value[index] = el
  }
}

// Mesure l'élément cliqué et aligne la navette par rapport au container.
function placeNavette(li: HTMLElement) {
  const container = containerRef.value
  if (!container) return
  const liRect = li.getBoundingClientRect()
  const containerRect = container.getBoundingClientRect()
  navette.value = {
    width: `${liRect.width}px`,
    height: `${liRect.height}px`,
    left: `${liRect.left - containerRect.left}px`,
    top: '0px',
    opacity: '1',
  }
}

function placeNavetteAtIndex(index: number) {
  const li = itemRefs.value[index]
  if (!li) return
  placeNavette(li)
}

function setActiveIndex(index: number) {
  activeIndex.value = index
  placeNavetteAtIndex(index)
}

// Limite les recalculs de layout à une frame pendant les resize rapides.
function scheduleReposition() {
  if (resizeRaf) return
  resizeRaf = requestAnimationFrame(() => {
    resizeRaf = 0
    placeNavetteAtIndex(activeIndex.value)
  })
}

onMounted(async () => {
  await nextTick()
  placeNavetteAtIndex(activeIndex.value)
  window.addEventListener('resize', scheduleReposition)

  if (containerRef.value) {
    resizeObserver = new ResizeObserver(() => {
      scheduleReposition()
    })
    resizeObserver.observe(containerRef.value)
  }
})

onBeforeUnmount(() => {
  window.removeEventListener('resize', scheduleReposition)
  resizeObserver?.disconnect()
  resizeObserver = null
  if (resizeRaf) {
    cancelAnimationFrame(resizeRaf)
    resizeRaf = 0
  }
})
</script>
<style scoped lang="scss">
.container {
  width: min(92%, 980px);
  height: clamp(44px, 6vw, 56px);
  background: var(--color-primary);
  margin: auto;
  border-radius: 50px;
  display: flex;
  align-items: center;
  position: relative;
  overflow: hidden;

  .navette {
    position: absolute;
    background: var(--color-text);
    box-sizing: border-box;
    border-radius: 50px;
    transition:
      left 0.2s ease,
      width 0.2s ease;
    pointer-events: none;
    z-index: 0;
  }

  ul {
    display: flex;
    justify-content: space-around;
    align-items: center;
    height: 100%;
    width: 100%;
    list-style: none;
    gap: clamp(6px, 1.5vw, 18px);
    padding: 0;
    margin: 0;
    position: relative;
    z-index: 1;
    li {
      height: 100%;
      display: flex;
      align-items: center;
      justify-content: center;
      white-space: nowrap;
      padding: 0 clamp(12px, 3vw, 46px);
      font-size: clamp(14px, 2vw, 20px);
      color: var(--color-text);
      transition: color 0.2s ease;
      cursor: pointer;
      &.active {
        color: var(--color-primary);
        font-weight: bold;
      }
    }
  }
}
</style>
