<template>
  <aside class="py-6 px-2 sm:px-6 md:col-span-3 md:py-0 md:px-0">
    <nav class="space-y-1">
      <router-link
        v-for="item in subNavigation"
        :key="item.name"
        :to="item.href"
        class="text-gray-900 hover:bg-gray-50 hover:text-gray-900 group flex items-center rounded-md px-3 py-2 text-sm font-medium"
        exact-active-class="bg-gray-50 text-lime-600 hover:bg-white"
      >
        <component
          :is="item.icon"
          class="text-gray-400 group-hover:text-gray-500 -ml-1 mr-3 h-6 w-6 flex-shrink-0"
          exact-active-class="text-lime-500"
          aria-hidden="true"
        />
        <span class="truncate">{{ item.name }}</span>
      </router-link>
    </nav>
  </aside>
</template>

<script setup>
import { CogIcon, KeyIcon, UserCircleIcon } from "@heroicons/vue/24/outline";
const subNavigation = [
  { name: "Profile", href: "/profile", icon: UserCircleIcon },
  { name: "Account", href: "/account", icon: CogIcon },
  { name: "Settings", href: "/settings", icon: KeyIcon },
];
</script>
