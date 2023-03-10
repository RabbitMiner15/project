<template>
  <div class="h-full">
    <main class="mx-auto max-w-7xl pb-10 md:py-12 md:px-8">
      <div class="md:grid md:grid-cols-12 md:gap-x-5">
        <Sidebar />
        <!-- Payment details -->
        <div class="space-y-6 sm:px-6 md:col-span-9 md:px-0">
          <section aria-labelledby="payment-details-heading">
            <form action="#" method="POST">
              <div class="shadow sm:overflow-hidden sm:rounded-md">
                <div class="bg-white py-6 px-4 sm:p-6">
                  <div>
                    <h2
                      id="payment-details-heading"
                      class="text-lg font-medium leading-6 text-gray-900"
                    >
                      Interests
                    </h2>
                  </div>

                  <div class="px-4 sm:px-6 md:px-8">
                    <div class="mt-8 flow-root">
                      <div
                        class="-my-2 -mx-4 overflow-x-auto sm:-mx-6 md:-mx-8"
                      >
                        <div
                          class="inline-block min-w-full py-2 align-middle sm:px-6 md:px-8"
                        >
                          <div class="relative">
                            <table
                              class="min-w-full table-fixed divide-y divide-gray-300"
                            >
                              <thead>
                                <tr>
                                  <th
                                    scope="col"
                                    class="relative px-7 sm:w-12 sm:px-6"
                                  >
                                    <input
                                      type="checkbox"
                                      class="absolute left-4 top-1/2 -mt-2 h-4 w-4 rounded border-gray-300 text-lime-600 focus:ring-lime-600"
                                      :checked="
                                        indeterminateHealth ||
                                        selectedHealth.length ===
                                          interests.slice(0, 6).length
                                      "
                                      :indeterminate="indeterminateHealth"
                                      @change="
                                        selectedHealth = $event.target.checked
                                          ? interests
                                              .slice(0, 6)
                                              .map((i) => i.id)
                                          : []
                                      "
                                    />
                                  </th>
                                  <th
                                    scope="col"
                                    class="min-w-[12rem] py-3.5 pr-3 text-left text-sm font-semibold text-gray-900"
                                  >
                                    Health
                                  </th>
                                  <th
                                    scope="col"
                                    class="px-3 py-3.5 text-left text-sm font-semibold text-gray-900"
                                  >
                                    Origin
                                  </th>
                                  <th
                                    scope="col"
                                    class="px-3 py-3.5 text-left text-sm font-semibold text-gray-900"
                                  >
                                    Privacy
                                  </th>
                                </tr>
                              </thead>
                              <tbody class="divide-y divide-gray-200 bg-white">
                                <tr
                                  v-for="interest in interests.slice(0, 6)"
                                  :key="interest.id"
                                  :class="[
                                    selectedHealth.includes(interest.id) &&
                                      'bg-gray-50',
                                  ]"
                                >
                                  <td class="relative px-7 sm:w-12 sm:px-6">
                                    <div
                                      v-if="
                                        selectedHealth.includes(interest.id)
                                      "
                                      class="absolute inset-y-0 left-0 w-0.5 bg-lime-600"
                                    ></div>
                                    <input
                                      type="checkbox"
                                      class="absolute left-4 top-1/2 -mt-2 h-4 w-4 rounded border-gray-300 text-lime-600 focus:ring-lime-600"
                                      :value="interest.id"
                                      v-model="selectedHealth"
                                    />
                                  </td>
                                  <td
                                    :class="[
                                      'whitespace-nowrap py-4 pr-3 text-sm font-medium',
                                      selectedHealth.includes(interest.id)
                                        ? 'text-lime-600'
                                        : 'text-gray-900',
                                    ]"
                                  >
                                    {{ interest.name }}
                                  </td>
                                  <td
                                    class="whitespace-nowrap px-3 py-4 text-sm text-gray-500"
                                  >
                                    {{ interest.origin }}
                                  </td>

                                  <td
                                    class="whitespace-nowrap px-3 py-4 text-sm font-medium sm:pr-3"
                                  >
                                    <SwitchGroup
                                      v-if="
                                        selectedHealth.includes(interest.id)
                                      "
                                      as="div"
                                      class="flex items-center"
                                    >
                                      <Switch
                                        v-model="
                                          enabledSwitches[interest.id - 1]
                                        "
                                        :class="[
                                          enabledSwitches[interest.id - 1]
                                            ? 'bg-lime-500'
                                            : 'bg-gray-200',
                                          'relative inline-flex h-6 w-11 flex-shrink-0 cursor-pointer rounded-full border-2 border-transparent transition-colors duration-200 ease-in-out',
                                        ]"
                                      >
                                        <span
                                          aria-hidden="true"
                                          :class="[
                                            enabledSwitches[interest.id - 1]
                                              ? 'translate-x-5'
                                              : 'translate-x-0',
                                            'inline-block h-5 w-5 transform rounded-full bg-white shadow ring-0 transition duration-200 ease-in-out',
                                          ]"
                                        />
                                      </Switch>
                                    </SwitchGroup>
                                  </td>
                                </tr>
                              </tbody>
                            </table>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                  <div class="px-4 sm:px-6 md:px-8">
                    <div class="mt-8 flow-root">
                      <div
                        class="-my-2 -mx-4 overflow-x-auto sm:-mx-6 md:-mx-8"
                      >
                        <div
                          class="inline-block min-w-full py-2 align-middle sm:px-6 md:px-8"
                        >
                          <div class="relative">
                            <table
                              class="min-w-full table-fixed divide-y divide-gray-300"
                            >
                              <thead>
                                <tr>
                                  <th
                                    scope="col"
                                    class="relative px-7 sm:w-12 sm:px-6"
                                  >
                                    <input
                                      type="checkbox"
                                      class="absolute left-4 top-1/2 -mt-2 h-4 w-4 rounded border-gray-300 text-lime-600 focus:ring-lime-600"
                                      :checked="
                                        indeterminateTracker ||
                                        selectedTracker.length ===
                                          interests.slice(6, 11).length
                                      "
                                      :indeterminate="indeterminateTracker"
                                      @change="
                                        selectedTracker = $event.target.checked
                                          ? interests
                                              .slice(6, 11)
                                              .map((i) => i.id)
                                          : []
                                      "
                                    />
                                  </th>
                                  <th
                                    scope="col"
                                    class="min-w-[12rem] py-3.5 pr-3 text-left text-sm font-semibold text-gray-900"
                                  >
                                    Tracker
                                  </th>
                                  <th
                                    scope="col"
                                    class="px-3 py-3.5 text-left text-sm font-semibold text-gray-900"
                                  >
                                    Origin
                                  </th>
                                  <th
                                    scope="col"
                                    class="px-3 py-3.5 text-left text-sm font-semibold text-gray-900"
                                  >
                                    Privacy
                                  </th>
                                </tr>
                              </thead>
                              <tbody class="divide-y divide-gray-200 bg-white">
                                <tr
                                  v-for="interest in interests.slice(6, 11)"
                                  :key="interest.id"
                                  :class="[
                                    selectedTracker.includes(interest.id) &&
                                      'bg-gray-50',
                                  ]"
                                >
                                  <td class="relative px-7 sm:w-12 sm:px-6">
                                    <div
                                      v-if="
                                        selectedTracker.includes(interest.id)
                                      "
                                      class="absolute inset-y-0 left-0 w-0.5 bg-lime-600"
                                    ></div>
                                    <input
                                      type="checkbox"
                                      class="absolute left-4 top-1/2 -mt-2 h-4 w-4 rounded border-gray-300 text-lime-600 focus:ring-lime-600"
                                      :value="interest.id"
                                      v-model="selectedTracker"
                                    />
                                  </td>
                                  <td
                                    :class="[
                                      'whitespace-nowrap py-4 pr-3 text-sm font-medium',
                                      selectedTracker.includes(interest.id)
                                        ? 'text-lime-600'
                                        : 'text-gray-900',
                                    ]"
                                  >
                                    {{ interest.name }}
                                  </td>
                                  <td
                                    class="whitespace-nowrap px-3 py-4 text-sm text-gray-500"
                                  >
                                    {{ interest.origin }}
                                  </td>

                                  <td
                                    class="whitespace-nowrap px-3 py-4 text-sm font-medium sm:pr-3"
                                  >
                                    <SwitchGroup
                                      v-if="
                                        selectedTracker.includes(interest.id)
                                      "
                                      as="div"
                                      class="flex items-center"
                                    >
                                      <Switch
                                        v-model="
                                          enabledSwitches[interest.id - 1]
                                        "
                                        :class="[
                                          enabledSwitches[interest.id - 1]
                                            ? 'bg-lime-500'
                                            : 'bg-gray-200',
                                          'relative inline-flex h-6 w-11 flex-shrink-0 cursor-pointer rounded-full border-2 border-transparent transition-colors duration-200 ease-in-out',
                                        ]"
                                      >
                                        <span
                                          aria-hidden="true"
                                          :class="[
                                            enabledSwitches[interest.id - 1]
                                              ? 'translate-x-5'
                                              : 'translate-x-0',
                                            'inline-block h-5 w-5 transform rounded-full bg-white shadow ring-0 transition duration-200 ease-in-out',
                                          ]"
                                        />
                                      </Switch>
                                    </SwitchGroup>
                                  </td>
                                </tr>
                              </tbody>
                            </table>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                  <div class="px-4 sm:px-6 md:px-8">
                    <div class="mt-8 flow-root">
                      <div
                        class="-my-2 -mx-4 overflow-x-auto sm:-mx-6 md:-mx-8"
                      >
                        <div
                          class="inline-block min-w-full py-2 align-middle sm:px-6 md:px-8"
                        >
                          <div class="relative">
                            <table
                              class="min-w-full table-fixed divide-y divide-gray-300"
                            >
                              <thead>
                                <tr>
                                  <th
                                    scope="col"
                                    class="relative px-7 sm:w-12 sm:px-6"
                                  >
                                    <input
                                      type="checkbox"
                                      class="absolute left-4 top-1/2 -mt-2 h-4 w-4 rounded border-gray-300 text-lime-600 focus:ring-lime-600"
                                      :checked="
                                        indeterminateFitness ||
                                        selectedFitness.length ===
                                          interests.slice(11, 13).length
                                      "
                                      :indeterminate="indeterminateFitness"
                                      @change="
                                        selectedFitness = $event.target.checked
                                          ? interests
                                              .slice(11, 13)
                                              .map((i) => i.id)
                                          : []
                                      "
                                    />
                                  </th>
                                  <th
                                    scope="col"
                                    class="min-w-[12rem] py-3.5 pr-3 text-left text-sm font-semibold text-gray-900"
                                  >
                                    Fitness
                                  </th>
                                  <th
                                    scope="col"
                                    class="px-3 py-3.5 text-left text-sm font-semibold text-gray-900"
                                  >
                                    Origin
                                  </th>
                                  <th
                                    scope="col"
                                    class="px-3 py-3.5 text-left text-sm font-semibold text-gray-900"
                                  >
                                    Privacy
                                  </th>
                                </tr>
                              </thead>
                              <tbody class="divide-y divide-gray-200 bg-white">
                                <tr
                                  v-for="interest in interests.slice(11, 13)"
                                  :key="interest.id"
                                  :class="[
                                    selectedFitness.includes(interest.id) &&
                                      'bg-gray-50',
                                  ]"
                                >
                                  <td class="relative px-7 sm:w-12 sm:px-6">
                                    <div
                                      v-if="
                                        selectedFitness.includes(interest.id)
                                      "
                                      class="absolute inset-y-0 left-0 w-0.5 bg-lime-600"
                                    ></div>
                                    <input
                                      type="checkbox"
                                      class="absolute left-4 top-1/2 -mt-2 h-4 w-4 rounded border-gray-300 text-lime-600 focus:ring-lime-600"
                                      :value="interest.id"
                                      v-model="selectedFitness"
                                    />
                                  </td>
                                  <td
                                    :class="[
                                      'whitespace-nowrap py-4 pr-3 text-sm font-medium',
                                      selectedFitness.includes(interest.id)
                                        ? 'text-lime-600'
                                        : 'text-gray-900',
                                    ]"
                                  >
                                    {{ interest.name }}
                                  </td>
                                  <td
                                    class="whitespace-nowrap px-3 py-4 text-sm text-gray-500"
                                  >
                                    {{ interest.origin }}
                                  </td>

                                  <td
                                    class="whitespace-nowrap px-3 py-4 text-sm font-medium sm:pr-3"
                                  >
                                    <SwitchGroup
                                      v-if="
                                        selectedFitness.includes(interest.id)
                                      "
                                      as="div"
                                      class="flex items-center"
                                    >
                                      <Switch
                                        v-model="
                                          enabledSwitches[interest.id - 1]
                                        "
                                        :class="[
                                          enabledSwitches[interest.id - 1]
                                            ? 'bg-lime-500'
                                            : 'bg-gray-200',
                                          'relative inline-flex h-6 w-11 flex-shrink-0 cursor-pointer rounded-full border-2 border-transparent transition-colors duration-200 ease-in-out',
                                        ]"
                                      >
                                        <span
                                          aria-hidden="true"
                                          :class="[
                                            enabledSwitches[interest.id - 1]
                                              ? 'translate-x-5'
                                              : 'translate-x-0',
                                            'inline-block h-5 w-5 transform rounded-full bg-white shadow ring-0 transition duration-200 ease-in-out',
                                          ]"
                                        />
                                      </Switch>
                                    </SwitchGroup>
                                  </td>
                                </tr>
                              </tbody>
                            </table>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="bg-gray-50 px-4 py-3 text-right sm:px-6">
                  <button
                    type="submit"
                    class="inline-flex justify-center items-center rounded-md border border-gray-300 bg-white px-4 py-2 text-sm font-medium text-gray-700 shadow-sm hover:bg-gray-50"
                  >
                    Save
                  </button>
                </div>
              </div>
            </form>
          </section>

          <!-- Plan -->
          <section aria-labelledby="plan-heading">
            <form action="#" method="POST">
              <div class="shadow sm:overflow-hidden sm:rounded-md">
                <div class="space-y-6 bg-white py-6 px-4 sm:p-6">
                  <div>
                    <h2
                      id="plan-heading"
                      class="text-lg font-medium leading-6 text-gray-900"
                    >
                      Displayed Achievements
                    </h2>
                  </div>
                  <div
                    class="grid grid-cols-1 divide-y divide-gray-200 border-gray-200 sm:grid-cols-5 sm:divide-y-0 sm:divide-x"
                  >
                    <div
                      @click="open = true"
                      v-for="achievement in user.visibleAchievements"
                      :key="achievements[achievement - 1].id"
                      class="px-6 py-5 text-center text-sm font-medium"
                    >
                      <component
                        :is="
                          interests[
                            achievements[achievement - 1].fiInterest - 1
                          ].icon
                        "
                        :class="[
                          interests[
                            achievements[achievement - 1].fiInterest - 1
                          ].fg,
                          'm-auto h-10 w-10',
                        ]"
                      ></component>
                      {{ " " }}
                      <span class="text-gray-600">{{
                        achievements[achievement - 1].name
                      }}</span>
                    </div>
                  </div>
                  <TransitionRoot as="template" :show="open">
                    <Dialog
                      as="div"
                      class="relative z-10"
                      @close="open = false"
                    >
                      <TransitionChild
                        as="template"
                        enter="ease-out duration-300"
                        enter-from="opacity-0"
                        enter-to="opacity-100"
                        leave="ease-in duration-200"
                        leave-from="opacity-100"
                        leave-to="opacity-0"
                      >
                        <div
                          class="fixed inset-0 bg-gray-500 bg-opacity-75 transition-opacity"
                        />
                      </TransitionChild>

                      <div class="fixed inset-0 z-10 overflow-y-auto">
                        <div
                          class="flex min-h-full items-end justify-center p-4 text-center sm:items-center sm:p-0"
                        >
                          <TransitionChild
                            as="template"
                            enter="ease-out duration-300"
                            enter-from="opacity-0 translate-y-4 sm:translate-y-0 sm:scale-95"
                            enter-to="opacity-100 translate-y-0 sm:scale-100"
                            leave="ease-in duration-200"
                            leave-from="opacity-100 translate-y-0 sm:scale-100"
                            leave-to="opacity-0 translate-y-4 sm:translate-y-0 sm:scale-95"
                          >
                            <DialogPanel
                              class="relative transform overflow-hidden rounded-lg bg-white px-4 pt-5 pb-4 text-left shadow-xl transition-all sm:my-8 sm:w-full sm:max-w-sm sm:p-6"
                            >
                              <div>
                                <div class="text-center">
                                  <DialogTitle
                                    as="h3"
                                    class="text-base font-semibold leading-6 text-gray-900"
                                    >Select an achievement</DialogTitle
                                  >
                                  <div class="mt-2 grid grid-cols-5 gap-1">
                                    <div
                                      v-for="achievement in achievements"
                                      :key="achievement.id"
                                      class="px-6 py-5 text-center text-sm font-medium"
                                    >
                                      <component
                                        :is="
                                          interests[achievement.fiInterest - 1]
                                            .icon
                                        "
                                        :class="[
                                          interests[achievement.fiInterest - 1]
                                            .fg,
                                          'm-auto h-10 w-10',
                                        ]"
                                      ></component>
                                      {{ " " }}
                                      <span class="text-gray-600">{{
                                        achievement.name
                                      }}</span>
                                    </div>
                                  </div>
                                </div>
                              </div>
                              <div class="mt-5 sm:mt-6">
                                <button
                                  type="button"
                                  class="inline-flex w-full justify-center rounded-md border border-transparent bg-lime-600 px-4 py-2 text-base font-medium text-white shadow-sm hover:bg-lime-700 focus:outline-none focus:ring-2 focus:ring-lime-500 focus:ring-offset-2 sm:text-sm"
                                  @click="open = false"
                                >
                                  Close
                                </button>
                              </div>
                            </DialogPanel>
                          </TransitionChild>
                        </div>
                      </div>
                    </Dialog>
                  </TransitionRoot>
                </div>
                <div class="bg-gray-50 px-4 py-3 text-right sm:px-6">
                  <button
                    type="submit"
                    class="inline-flex justify-center items-center rounded-md border border-gray-300 bg-white px-4 py-2 text-sm font-medium text-gray-700 shadow-sm hover:bg-gray-50"
                  >
                    Save
                  </button>
                </div>
              </div>
            </form>
          </section>
        </div>
      </div>
    </main>
  </div>
</template>

<script setup>
import { ref, computed } from "vue";
import { Switch, SwitchGroup } from "@headlessui/vue";
import Sidebar from "../../components/Sidebar.vue";
import interests from "../../interests";
import achievements from "../../achievements";
import users from "../../users";
import {
  Dialog,
  DialogPanel,
  DialogTitle,
  TransitionChild,
  TransitionRoot,
} from "@headlessui/vue";
import { useUserStore } from "../../store/user";
const userState = useUserStore();

const open = ref(false);
const user = users[0];
const enabledSwitches = ref(Array(interests.length).fill(false));
const selectedHealth = ref([]);
const selectedTracker = ref([]);
const selectedFitness = ref([]);
const checked = ref(false);
const indeterminateHealth = computed(
  () =>
    selectedHealth.value.length > 0 &&
    selectedHealth.value.length < interests.length
);
const indeterminateTracker = computed(
  () =>
    selectedTracker.value.length > 0 &&
    selectedTracker.value.length < interests.length
);
const indeterminateFitness = computed(
  () =>
    selectedFitness.value.length > 0 &&
    selectedFitness.value.length < interests.length
);
</script>
