<template>
  <div class="bg-white">
    <div>
      <!-- Mobile filter dialog -->
      <TransitionRoot as="template" :show="mobileFiltersOpen">
        <Dialog
          as="div"
          class="relative z-40 md:hidden"
          @close="mobileFiltersOpen = false"
        >
          <TransitionChild
            as="template"
            enter="transition-opacity ease-linear duration-300"
            enter-from="opacity-0"
            enter-to="opacity-100"
            leave="transition-opacity ease-linear duration-300"
            leave-from="opacity-100"
            leave-to="opacity-0"
          >
            <div class="fixed inset-0 bg-black bg-opacity-25" />
          </TransitionChild>

          <div class="fixed inset-0 z-40 flex">
            <TransitionChild
              as="template"
              enter="transition ease-in-out duration-300 transform"
              enter-from="translate-x-full"
              enter-to="translate-x-0"
              leave="transition ease-in-out duration-300 transform"
              leave-from="translate-x-0"
              leave-to="translate-x-full"
            >
              <DialogPanel
                class="relative ml-auto flex h-full w-full max-w-xs flex-col overflow-y-auto bg-white py-4 pb-6 shadow-xl"
              >
                <div class="flex items-center justify-between px-4">
                  <h2 class="text-lg font-medium text-gray-900">Filters</h2>
                  <button
                    type="button"
                    class="-mr-2 flex h-10 w-10 items-center justify-center p-2 text-gray-400 hover:text-gray-500"
                    @click="mobileFiltersOpen = false"
                  >
                    <XMarkIcon class="h-6 w-6" aria-hidden="true" />
                  </button>
                </div>

                <!-- Filters -->
                <form class="mt-4">
                  <Disclosure
                    as="div"
                    v-for="section in filters"
                    :key="section.name"
                    class="border-t border-gray-200 pt-4 pb-4"
                    v-slot="{ open }"
                  >
                    <fieldset>
                      <legend class="w-full px-2">
                        <DisclosureButton
                          class="flex w-full items-center justify-between p-2 text-gray-400 hover:text-gray-500"
                        >
                          <span class="text-sm font-medium text-gray-900">{{
                            section.name
                          }}</span>
                          <span class="ml-6 flex h-7 items-center">
                            <ChevronDownIcon
                              :class="[
                                open ? '-rotate-180' : 'rotate-0',
                                'h-5 w-5 transform',
                              ]"
                              aria-hidden="true"
                            />
                          </span>
                        </DisclosureButton>
                      </legend>
                      <DisclosurePanel class="px-4 pt-4 pb-2">
                        <div class="space-y-6">
                          <div
                            v-for="(option, optionIdx) in section.options"
                            :key="option.value"
                            class="flex items-center"
                          >
                            <input
                              :id="`${section.id}-${optionIdx}-mobile`"
                              :name="`${section.id}[]`"
                              :value="option.value"
                              v-model="selected"
                              type="checkbox"
                              class="h-4 w-4 rounded border-gray-300 text-lime-600 focus:ring-lime-500"
                            />
                            <label
                              :for="`${section.id}-${optionIdx}-mobile`"
                              class="ml-3 text-sm text-gray-500"
                              >{{ option.label }}</label
                            >
                          </div>
                        </div>
                      </DisclosurePanel>
                    </fieldset>
                  </Disclosure>
                </form>
              </DialogPanel>
            </TransitionChild>
          </div>
        </Dialog>
      </TransitionRoot>

      <main class="mx-auto max-w-2xl px-4 md:max-w-7xl md:px-8">
        <div class="border-b border-gray-200 pt-24 pb-10">
          <h1 class="text-4xl font-bold tracking-tight text-gray-900">
            Groups
          </h1>
          <div class="mt-4 flex justify-between">
            <p class="text-base text-gray-500">
              See all your groups and invites!
            </p>
            <button
              class="rounded-md border border-gray-300 bg-white px-4 py-2 text-sm font-medium text-gray-700 shadow-sm hover:bg-gray-50 focus:ring-lime-500"
            >
              Add Group
            </button>
          </div>
        </div>

        <div class="md:grid md:grid-cols-5 md:gap-2">
          <aside class="pt-3 pb-6 md:pt-6 md:pb-12 md:col-span-1">
            <button
              type="button"
              class="inline-flex items-center md:hidden"
              @click="mobileFiltersOpen = true"
            >
              <span class="text-sm font-medium text-gray-700">Filters</span>
              <PlusIcon
                class="ml-1 h-5 w-5 flex-shrink-0 text-gray-400"
                aria-hidden="true"
              />
            </button>

            <div class="hidden md:block">
              <form class="space-y-10 divide-y divide-gray-200">
                <div
                  v-for="(section, sectionIdx) in filters"
                  :key="section.name"
                  :class="sectionIdx === 0 ? null : 'pt-10'"
                >
                  <fieldset>
                    <legend class="block text-sm font-medium text-gray-900">
                      {{ section.name }}
                    </legend>
                    <div class="space-y-3 pt-6">
                      <div
                        v-for="(option, optionIdx) in section.options"
                        :key="option.value"
                        class="flex items-center"
                      >
                        <input
                          :id="`${section.id}-${optionIdx}`"
                          :name="`${section.id}[]`"
                          :value="option.value"
                          v-model="selected"
                          type="checkbox"
                          class="h-4 w-4 rounded border-gray-300 text-lime-600 focus:ring-lime-500"
                        />
                        <label
                          :for="`${section.id}-${optionIdx}`"
                          class="ml-3 text-sm text-gray-600"
                          >{{ option.label }}</label
                        >
                      </div>
                    </div>
                  </fieldset>
                </div>
              </form>
            </div>
          </aside>

          <div class="sm:my-auto overflow-hidden h-full md:col-span-4">
            <ul role="list" class="">
              <template v-for="group in filter" :key="group.idGroup">
                <li
                  v-if="group.dtAccepted"
                  class="px-4 py-4 sm:px-6 block hover:bg-gray-50 bg-white border shadow-sm my-3 sm:rounded-md"
                >
                  <router-link :to="'/groups/' + group.idGroup" class="">
                    <div class="">
                      <div class="flex items-center justify-between">
                        <div class="flex flex-row">
                          <p class="truncate text-sm font-medium text-lime-600">
                            {{ group.dtGroupName }}
                          </p>
                        </div>
                      </div>
                      <div class="mt-2 sm:flex sm:justify-between">
                        <div class="sm:flex">
                          <p class="flex items-center text-sm text-gray-500">
                            {{ group.members[0].dtUsername }}
                          </p>
                        </div>
                        <div
                          class="mt-2 flex items-center text-sm text-gray-500 sm:mt-0 sm:ml-6 sm:w-1/2"
                        >
                          <div
                            class="w-full bg-gray-200 rounded-full dark:bg-gray-700"
                          ></div>
                        </div>
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
                        </div>
                      </div>
                    </div>
                  </router-link>
                </li>
              </template>
            </ul>
          </div>
        </div>
        <div class="border-b border-gray-200 pt-24 pb-10">
          <h1 class="text-4xl font-bold tracking-tight text-gray-900">
            Invites
          </h1>
        </div>
        <div class="md:grid md:grid-cols-5 md:gap-2">
          <aside class="pt-3 pb-6 md:pt-6 md:pb-12 md:col-span-1"></aside>

          <div class="sm:my-auto overflow-hidden md:col-span-4 h-full">
            <ul role="list" class="">
              <template v-for="group in groups" :key="group.idGroup">
                <li
                  v-if="!group.dtAccepted"
                  class="block hover:bg-gray-50 bg-white cursor-pointer px-4 py-4 sm:px-6 border shadow-sm sm:rounded-md my-3"
                >
                  <div class="">
                    <div class="">
                      <div class="flex items-center justify-between">
                        <div class="flex flex-row">
                          <p class="truncate text-sm font-medium text-lime-600">
                            {{ group.dtGroupName }}
                          </p>
                        </div>
                      </div>
                      <div class="mt-2 sm:flex sm:justify-between">
                        <div class="sm:flex">
                          <p class="flex items-center text-sm text-gray-500">
                            {{ group.members[0].dtUsername }}
                          </p>
                        </div>
                        <div
                          class="mt-2 flex items-center text-sm text-gray-500 sm:mt-0 sm:ml-6 sm:w-1/2"
                        >
                          <div
                            class="w-full bg-gray-200 rounded-full dark:bg-gray-700"
                          ></div>
                        </div>
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
                        </div>
                      </div>
                    </div>
                  </div>
                </li>
              </template>
            </ul>
          </div>
        </div>
      </main>
    </div>
  </div>
</template>

<script setup>
import { ref, computed } from "vue";
import {
  Dialog,
  DialogPanel,
  Disclosure,
  DisclosureButton,
  DisclosurePanel,
  TransitionChild,
  TransitionRoot,
} from "@headlessui/vue";
import { XMarkIcon } from "@heroicons/vue/24/outline";
import { ChevronDownIcon, PlusIcon } from "@heroicons/vue/20/solid";
import { useUserStore } from "../store/user";
import axios from "axios";
const userState = useUserStore();
const groups = ref([]);
axios
  .post("/getGroups.php", {
    idUser: userState.user.idUser,
  })
  .then((response) => {
    groups.value = response.data;
  })
  .catch((error) => {
    console.error(error);
  });

const filters = [
  {
    id: "filter",
    name: "Filter",
    options: [{ value: userState.user.idUser, label: "My Groups" }],
  },
];
const selected = ref([]);
const filter = computed(() => {
  if (selected.value.length === 0) {
    return groups.value[0].value;
  } else {
    return groups.value[0].value.filter((group) =>
      selected.value.includes(group.fiUser)
    );
  }
});

const mobileFiltersOpen = ref(false);
</script>
