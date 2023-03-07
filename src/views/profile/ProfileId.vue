<template>
  <div class="mx-auto max-w-3xl px-4 sm:px-6 md:max-w-7xl md:px-8">
    <div class="grid grid-cols-1 items-start gap-4 md:grid-cols-3 md:gap-8">
      <div class="grid grid-cols-1 gap-4 md:col-span-2">
        <section aria-labelledby="profile-overview-title">
          <div class="overflow-hidden rounded-lg bg-white shadow">
            <div class="bg-white p-6">
              <div class="sm:flex sm:items-center sm:justify-between">
                <div class="sm:flex sm:space-x-5">
                  <div class="flex-shrink-0">
                    <img
                      class="mx-auto h-20 w-20 rounded-full"
                      :src="'/' + user.picture + '.png'"
                      alt=""
                    />
                  </div>
                  <div class="mt-6 text-center sm:mt-0 sm:pt-1 sm:text-left">
                    <p class="text-sm font-medium text-gray-600">This is,</p>
                    <p class="text-xl font-bold text-gray-900 sm:text-2xl">
                      {{ user.name }}
                    </p>
                  </div>
                </div>
              </div>
            </div>
            <div
              class="grid grid-cols-1 divide-y divide-gray-200 border-t border-gray-200 bg-gray-50 sm:grid-cols-5 sm:divide-y-0 sm:divide-x"
            >
              <div
                v-for="achievement in user.visibleAchievements"
                :key="achievements[achievement - 1].id"
                class="px-6 py-5 text-center text-sm font-medium"
              >
                <component
                  :is="
                    interests[achievements[achievement - 1].fiInterest - 1].icon
                  "
                  :class="[
                    interests[achievements[achievement - 1].fiInterest - 1].fg,
                    'm-auto h-10 w-10',
                  ]"
                ></component>
                {{ " " }}
                <span class="text-gray-600">{{
                  achievements[achievement - 1].name
                }}</span>
              </div>
            </div>
          </div>
        </section>

        <!-- Actions panel -->
        <section aria-labelledby="quick-links-title">
          <div
            class="divide-y divide-gray-200 overflow-hidden rounded-lg bg-gray-200 shadow sm:grid sm:grid-cols-2 sm:gap-px sm:divide-y-0"
          >
            <div
              v-for="(interest, index) in user.visibleInterests"
              :key="interests[interest - 1].id"
              :class="[
                index === 0
                  ? 'rounded-tl-lg rounded-tr-lg sm:rounded-tr-none'
                  : '',
                index === 1 ? 'sm:rounded-tr-lg' : '',
                index === user.visibleInterests.length - 2
                  ? 'sm:rounded-bl-lg'
                  : '',
                index === user.visibleInterests.length - 1
                  ? 'rounded-bl-lg rounded-br-lg sm:rounded-bl-none'
                  : '',
                'group relative bg-white p-6 focus-within:ring-2 focus-within:ring-inset focus-within:ring-lime-500',
              ]"
            >
              <div class="flex-row flex">
                <span
                  :class="[
                    interests[interest - 1].bg,
                    interests[interest - 1].fg,
                    'inline-flex rounded-lg p-3 ring-4 ring-white',
                  ]"
                >
                  <component
                    :is="interests[interest - 1].icon"
                    class="h-6 w-6"
                    aria-hidden="true"
                  />
                </span>
                <h3 class="my-auto ml-2 text-lg font-medium">
                  <div>
                    {{ interests[interest - 1].name }}:
                    {{ user.progress[index].today
                    }}{{ interests[interest - 1].unit }}
                  </div>
                </h3>
              </div>
            </div>
          </div>
        </section>
      </div>

      <!-- Right column -->
      <div class="grid grid-cols-1 gap-4">
        <section aria-labelledby="stats-title">
          <div class="overflow-hidden rounded-lg bg-white shadow">
            <div class="p-6">
              <h2 class="text-base font-medium text-gray-900" id="stats-title">
                All time stats
              </h2>
              <div class="divide-y divide-gray-200">
                <p class="py-2">Joined: {{ user.joined }}</p>
                <p
                  class="py-2"
                  :key="index"
                  v-for="(interest, index) in user.visibleInterests"
                >
                  {{ interests[interest - 1].name }}:
                  {{ user.progress[index].progress
                  }}{{ interests[interest - 1].unit }}
                </p>
              </div>
            </div>
          </div>
        </section>
      </div>
    </div>
  </div>
</template>

<script setup>
import interests from "../../interests";
import users from "../../users";
import { useRoute } from "vue-router";
import { computed } from "vue";
import achievements from "../../achievements";

const route = useRoute();
const userId = computed(() => {
  const matches = route.path.match(/^\/profile\/(\d+)/);
  return matches ? parseInt(matches[1]) : null;
});
const user = computed(() => {
  return users.find((user) => user.id === userId.value);
});
</script>
