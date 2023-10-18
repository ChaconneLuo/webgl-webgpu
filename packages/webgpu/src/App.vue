<script setup lang="ts">
import { useRouter } from 'vue-router';
import routes from '~pages';

type ToggleSelect = '+' | '-';

const router = useRouter();
const toggleRoute = (select: ToggleSelect) => {
  const count = routes.length;
  const currentPath = router.currentRoute.value.path;

  const getRoutesIndex = () => {
    for (let i = 0; i < count; i++) {
      if (routes[i].path === currentPath) {
        return i;
      }
    }
    return 0;
  }

  switch (select) {
    case '+': {
      let index = getRoutesIndex();
      if (index === 0) {
        index = count - 1;
      } else {
        index--;
      }
      router.push(routes[index]);
      break;
    }
    case '-': {
      let index = getRoutesIndex();
      if (index === count - 1) {
        index = 0;
      } else {
        index++;
      }
      router.push(routes[index]);
      break;
    }
  }
}
</script>

<template>
  <div>
    <router-view></router-view>
  </div>
  <footer class="flex flex-row flex-justify-evenly">
    <button type="button" @click="toggleRoute('-')">pre</button>
    <button type="button" @click="toggleRoute('+')">next</button>
  </footer>
</template>

<style scoped></style>
