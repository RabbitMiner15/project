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
                      :src="user.imageUrl"
                      alt=""
                    />
                  </div>
                  <div class="mt-6 text-center sm:mt-0 sm:pt-1 sm:text-left">
                    <p class="text-sm font-medium text-gray-600">
                      Welcome back,
                    </p>
                    <p class="text-xl font-bold text-gray-900 sm:text-2xl">
                      {{ user.name }}
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
                v-for="stat in stats"
                :key="stat.label"
                class="px-6 py-5 text-center text-sm font-medium"
              >
                <span class="text-gray-900">{{ stat.value }}</span>
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
              v-for="(action, actionIdx) in actions"
              :key="action.interest.name"
              :class="[
                actionIdx === 0
                  ? 'rounded-tl-lg rounded-tr-lg sm:rounded-tr-none'
                  : '',
                actionIdx === 1 ? 'sm:rounded-tr-lg' : '',
                actionIdx === actions.length - 2 ? 'sm:rounded-bl-lg' : '',
                actionIdx === actions.length - 1
                  ? 'rounded-bl-lg rounded-br-lg sm:rounded-bl-none'
                  : '',
                'group relative bg-white p-6 focus-within:ring-2 focus-within:ring-inset focus-within:ring-lime-500',
              ]"
            >
              <div>
                <span
                  :class="[
                    action.interest.bg,
                    action.interest.fg,
                    'inline-flex rounded-lg p-3 ring-4 ring-white',
                  ]"
                >
                  <component
                    :is="action.interest.icon"
                    class="h-6 w-6"
                    aria-hidden="true"
                  />
                </span>
              </div>
              <div class="mt-8">
                <h3 class="text-lg font-medium">
                  <div @click="" class="focus:outline-none">
                    <!-- Extend touch target to entire panel -->
                    <span class="absolute inset-0 cursor-pointer" aria-hidden="true" />
                    {{ action.interest.name }}:  {{action.progress }}{{ action.interest.unit }}
                  </div>
                </h3>
                <p class="mt-2 text-sm text-gray-500">
                  {{ action.feedback }}
                </p>
              </div>
              <span
                class="pointer-events-none absolute top-6 right-6 text-gray-300 group-hover:text-lime-400"
                aria-hidden="true"
              >
                <PlusIcon class="h-6 w-6" fill="currentColor" viewBox="0 0 24 24"/>
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
                  <li v-for="goal in goals.slice(0,3)" :key="goal.id" class="py-5">
                    <div 
                      class="relative"
                    >
                      <h3 class="text-sm font-semibold text-gray-800">
                        
                          <!-- Extend touch target to entire panel -->
                          <span class="absolute inset-0" aria-hidden="true" />
                          {{ goal.target }}{{ interests[goal.idInterest-1].unit }}{{ " " }}{{ interests[goal.idInterest-1].name  }}{{ " in " }}{{ daysUntil(goal.deadline) }} {{ "days" }}
                        
                      </h3>
                      <p class="mt-1 text-sm text-gray-600 line-clamp-2">
                        <div class="w-full bg-gray-200 rounded-full dark:bg-gray-700">
                          <div class="bg-lime-600 text-xs font-medium text-blue-100 text-center p-0.5 leading-none rounded-full" :style="'width: ' + (goal.progress/goal.target) * 100 + '%'">
                            {{ Math.round(goal.progress/goal.target *100) }}%
                          </div>
                        </div>
                      </p>
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
              <h2
                class="text-base font-medium text-gray-900"
                id="groups-title"
              >
                Groups
              </h2>
              <div class="mt-6 flow-root">
                <ul role="list" class="-my-5 divide-y divide-gray-200">
                  <li
                    v-for="group in groups"
                    :key="group.id"
                    class="py-4"
                  >
                    <div class="flex -space-x-3 overflow-hidden">
                      <div v-for="picture in group.pictures" class="flex -space-x-2 overflow-hidden">
                        <img class="inline-block h-8 w-8 rounded-full" :src="'/'+picture+'.png'" alt="grouppicture" />
                      </div>
                      <div class="min-w-0 flex-1 pl-5">
                        <p class="truncate text-sm font-medium text-gray-900">
                          {{ group.groupName }}
                        </p>
                        <p class="truncate text-sm text-gray-500">
                          {{ group.description }}
                        </p>
                      </div>
                      <div>
                        <router-link
                          :to="'/groups/'+group.id"
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
import {
  PlusIcon,


} from "@heroicons/vue/24/outline";

import interests from "../interests.js"
import goals from "../goals.js"
import { daysUntil } from "../converter";
const user = {
  name: "Martin Kremer",
  email: "chelsea.hagon@example.com",
  imageUrl: "/2.png",
};



const actions = [
  {
    interest: interests[0],
    progress: 8,
    feedback: "Keep on going like this"
  },
  {
    interest: interests[1],
    progress: 2000,
    feedback: "Slight deficit for now"
  },
  {
    interest: interests[2],
    progress: 85,
    feedback: "Slightly above average"
  },
  {
    interest: interests[3],
    progress: 1.5,
    feedback: "Not far from the ideal amount"
  },
  {
    interest: interests[4],
    progress: 80,
    feedback: "Good"
  },
  {
    interest: interests[5],
    progress: 37,
    feedback: "Average"
  },
  {
    interest: interests[6],
    progress: 10,
    feedback: "Good work on living without meat"
  },
  {
    interest: interests[7],
    progress: 10,
    feedback: "Almost two weeks"
  },
  {
    interest: interests[8],
    progress: 50,
    feedback: "Who needs Sugar?"
  },
  {
    interest: interests[9],
    progress: 60,
    feedback: "Feeling better, right?"
  },
  {
    interest: interests[10],
    progress: 85,
    feedback: "Nice work"
  },
  {
    interest: interests[11],
    progress: 4,
    feedback: "Excellent work, on keeping yourself busy"
  },
  {
    interest: interests[12],
    progress: 2,
    feedback: "A bit more, could be good."
  },
  
];
const groups = [
  {
    id: 1,
    groupName: "Health Heroes",
    description: "Friends for health",
    pictures: [1,2,3],
  },
  {
    id: 2,
    groupName: "Brian Gains",
    description: "Let's get fit",
    pictures: [3,1,5],
  },
  {
    id: 3,
    groupName: "Martin Muscles",
    description: "Do you believe me?",
    pictures: [1,4,2],
  },
  
];


const stats = [
  { label: "Achievements", value: 12 },
  { label: "Goals", value: goals.length },
  { label: "Groups", value: groups.length },
];
</script>
