<template>
  <button type="button" @click="onClick" class="inline-flex items-center rounded-md border border-transparent bg-indigo-600 px-4 py-2 text-base font-medium text-white shadow-sm hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2">{{ buttonText }}</button>
</template>

<script>
export default {
  props: {
    buttonText: {
      type: String,
      required: true,
    },
    onClick: {
      type: Function,
      required: true,
    },
  },
};
</script>
