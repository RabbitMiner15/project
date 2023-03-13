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
                      :src="'/' + userState.user.dtPicture + '.png'"
                      alt=""
                    />
                  </div>
                  <div class="mt-6 text-center sm:mt-0 sm:pt-1 sm:text-left">
                    <p class="text-sm font-medium text-gray-600">
                      Welcome back,
                    </p>
                    <p class="text-xl font-bold text-gray-900 sm:text-2xl">
                      {{ userState.user.dtUsername }}
                    </p>
                  </div>
                </div>
                <div class="mt-5 flex justify-center sm:mt-0">
                  <router-link
                    to="/profile"
                    class="flex items-center justify-center rounded-md border border-gray-300 bg-white px-4 py-2 text-sm font-medium text-gray-700 shadow-sm hover:bg-gray-50"
                    >Edit Profile</router-link
                  >
                </div>
              </div>
            </div>
            <div
              class="grid grid-cols-1 divide-y divide-gray-200 border-t border-gray-200 bg-gray-50 sm:grid-cols-3 sm:divide-y-0 sm:divide-x"
            >
              <div
                v-for="stat in stats.slice(0, 3)"
                :key="stat.label"
                class="px-6 py-5 text-center text-sm font-medium"
              >
                <span class="text-gray-900">{{ stat.value.length }}</span>
                {{ " " }}
                <span class="text-gray-600">{{ stat.label }}</span>
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
              v-for="(interest, index) in userState.user.interests"
              :key="interest"
              :class="[
                index === 0
                  ? 'rounded-tl-lg rounded-tr-lg sm:rounded-tr-none'
                  : '',
                index === 1 ? 'sm:rounded-tr-lg' : '',
                index === userState.user.interests.length - 2
                  ? 'sm:rounded-bl-lg'
                  : '',
                index === userState.user.interests.length - 1
                  ? 'rounded-bl-lg rounded-br-lg sm:rounded-bl-none'
                  : '',
                'group relative bg-white p-6 focus-within:ring-2 focus-within:ring-inset focus-within:ring-lime-500',
              ]"
            >
              <div>
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
              </div>
              <div class="mt-8">
                <h3 class="text-lg font-medium">
                  <div @click="" class="focus:outline-none">
                    <!-- Extend touch target to entire panel -->
                    <span
                      class="absolute inset-0 cursor-pointer"
                      aria-hidden="true"
                    />
                    {{ interests[interest - 1].name }}:
                    {{ getProgress(interest, stats[3].progress) }}
                    {{ interests[interest - 1].unit }}
                  </div>
                </h3>
                <p class="mt-2 text-sm text-gray-500">TODO FEEDBACK</p>
              </div>
              <span
                class="pointer-events-none absolute top-6 right-6 text-gray-300 group-hover:text-lime-400"
                aria-hidden="true"
              >
                <PlusIcon
                  class="h-6 w-6"
                  fill="currentColor"
                  viewBox="0 0 24 24"
                />
              </span>
            </div>
          </div>
        </section>
      </div>

      <!-- Right column -->
      <div class="grid grid-cols-1 gap-4">
        <section aria-labelledby="goals-title">
          <div class="overflow-hidden rounded-lg bg-white shadow">
            <div class="p-6">
              <h2 class="text-base font-medium text-gray-900" id="goals-title">
                Goals
              </h2>
              <div class="mt-6 flow-root">
                <ul role="list" class="-my-5 divide-y divide-gray-200">
                  <li
                    v-for="goal in stats[1].value"
                    :key="goal.idGoal"
                    class="py-5"
                  >
                    <div class="relative">
                      <h3 class="text-sm font-semibold text-gray-800">
                        <span class="absolute inset-0" aria-hidden="true" />
                        {{ goal.dtTarget
                        }}{{ interests[goal.fiInterest - 1].unit }}{{ " "
                        }}{{ interests[goal.fiInterest - 1].name }}{{ " in "
                        }}{{ daysUntil(goal.dtDeadline) }}
                        {{ "days" }}
                      </h3>
                      <div class="mt-1 text-sm text-gray-600 line-clamp-2">
                        <div
                          class="w-full bg-gray-200 rounded-full dark:bg-gray-700"
                        >
                          <div
                            class="bg-lime-600 text-xs font-medium text-blue-100 text-center p-0.5 leading-none rounded-full"
                            :style="'width: ' + (1 / goal.dtTarget) * 100 + '%'"
                          >
                            {{ Math.round((1 / goal.dtTarget) * 100) }}%
                          </div>
                        </div>
                      </div>
                    </div>
                  </li>
                </ul>
              </div>
              <div class="mt-6">
                <router-link
                  to="/goals"
                  class="flex w-full items-center justify-center rounded-md border border-gray-300 bg-white px-4 py-2 text-sm font-medium text-gray-700 shadow-sm hover:bg-gray-50"
                  >View all</router-link
                >
              </div>
            </div>
          </div>
        </section>

        <section aria-labelledby="groups-title">
          <div class="overflow-hidden rounded-lg bg-white shadow">
            <div class="p-6">
              <h2 class="text-base font-medium text-gray-900" id="groups-title">
                Groups
              </h2>
              <div class="mt-6 flow-root">
                <ul role="list" class="-my-5 divide-y divide-gray-200">
                  <li
                    v-for="group in stats[2].value"
                    :key="group.idGroup"
                    class="py-4"
                  >
                    <div class="flex -space-x-3 overflow-hidden">
                      <div
                        v-for="(member, index) in group.members.slice(0, 3)"
                        :key="index"
                        class="flex -space-x-2 overflow-hidden"
                      >
                        <img
                          class="inline-block h-8 w-8 rounded-full"
                          :src="'/' + member.dtPicture + '.png'"
                          alt="grouppicture"
                        />
                      </div>
                      <div
                        v-if="group.members.length > 3"
                        class="flex items-center text-sm font font-medium text-gray-500 pl-4 bg"
                      >
                        <span
                          class="inline-block h-8 w-8 pt-0.5 text-center rounded-full border-black bg-gray-300"
                          >+{{ group.members.length - 3 }}</span
                        >
                      </div>

                      <div class="min-w-0 flex-1 pl-5">
                        <p class="truncate text-sm font-medium text-gray-900">
                          {{ group.dtGroupName }}
                        </p>
                        <p class="truncate text-sm text-gray-500">
                          {{ group.dtDescription }}
                        </p>
                      </div>
                      <div>
                        <router-link
                          :to="'/groups/' + group.idGroup"
                          class="inline-flex items-center rounded-full border border-gray-300 bg-white px-2.5 py-0.5 text-sm font-medium leading-5 text-gray-700 shadow-sm hover:bg-gray-50"
                          >View</router-link
                        >
                      </div>
                    </div>
                  </li>
                </ul>
              </div>
              <div class="mt-6">
                <router-link
                  to="/groups"
                  class="flex w-full items-center justify-center rounded-md border border-gray-300 bg-white px-4 py-2 text-sm font-medium text-gray-700 shadow-sm hover:bg-gray-50"
                  >View all</router-link
                >
              </div>
            </div>
          </div>
        </section>
      </div>
    </div>
  </div>
</template>

<script setup>
import { PlusIcon } from "@heroicons/vue/24/outline";
import interests from "../interests.js";
import { daysUntil, getProgress } from "../converter";
import { useUserStore } from "../store/user";
import axios from "axios";
import { ref } from "vue";
const userState = useUserStore();

const stats = ref([]);
axios
  .post("/getUserStats.php", {
    idUser: userState.user.idUser,
  })
  .then((response) => {
    stats.value = response.data;
    console.log(stats.value[1].progress[1]);
  })
  .catch((error) => {
    console.error(error);
  });
</script>
