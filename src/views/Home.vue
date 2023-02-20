<template>
  <CustomButton :buttonText="'Home'" :onClick="handleClick" />
</template>

<script setup>
import CustomButton from "../assets/CustomButton.vue";
import { useToast } from "vue-toastification";
const toast = useToast();
const handleClick = () => {
  toast.success("Success");
};
</script>
