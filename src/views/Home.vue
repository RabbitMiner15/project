<template>
  <component :is="loadComponent"></component>
</template>

<script setup>
import { computed } from "vue";
import { useUserStore } from "../store/user";
import HomeLoggedIn from "./HomeLoggedIn.vue";
import HomeLoggedOut from "./HomeLoggedOut.vue";

const loadComponent = computed(() => {
  const userStore = useUserStore();
  if (userStore.user) {
    return HomeLoggedIn;
  } else {
    return HomeLoggedOut;
  }
});
</script>
