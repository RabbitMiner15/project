<script setup>
import Sidebar from "./components/Header.vue";
import Footer from "./components/Footer.vue";
</script>

<template>
  <Sidebar>
    <router-view />
  </Sidebar>
  <Footer />
</template>
