<script setup>
import Sidebar from "./components/Sidebar.vue";
import Footer from "./components/Footer.vue";
</script>

<template>
  <!-- <router-link :to="{name: 'home'}">Home</router-link>
  <router-link :to="{name: 'tos'}">Terms of Service</router-link> -->
  <Sidebar>
    <router-view />
  </Sidebar>
  <Footer />
</template>
