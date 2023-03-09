<template>
  <div class="flex min-h-full flex-col justify-center py-12 sm:px-6 md:px-8">
    <div class="sm:mx-auto sm:w-full sm:max-w-md mb-5">
      <img
        class="mx-auto h-12 w-auto"
        src="https://tailwindui.com/img/logos/mark.svg?color=lime&shade=600"
        alt="Your Company"
      />
      <h2
        class="mt-6 text-center text-3xl font-bold tracking-tight text-gray-900"
      >
        Create your account
      </h2>
      <p class="mt-2 text-center text-sm text-gray-600">
        Or
        {{ " " }}
        <router-link
          to="/signin"
          class="font-medium text-lime-600 hover:text-lime-500"
          >sign in to your existing account</router-link
        >
      </p>
    </div>
    <nav aria-label="Progress">
      <ol
        role="list"
        class="divide-y divide-gray-300 rounded-md border border-gray-300 md:flex md:divide-y-0"
      >
        <li
          v-for="(step, stepIdx) in steps"
          :key="step.name"
          class="relative md:flex md:flex-1"
        >
          <div
            v-if="step.status === 'complete'"
            @click="step.function()"
            class="group flex w-full items-center cursor-pointer"
          >
            <span class="flex items-center px-6 py-4 text-sm font-medium">
              <span
                class="flex h-10 w-10 flex-shrink-0 items-center justify-center rounded-full bg-lime-600 group-hover:bg-lime-800"
              >
                <CheckIcon class="h-6 w-6 text-white" aria-hidden="true" />
              </span>
              <span class="ml-4 text-sm font-medium text-gray-900">{{
                step.name
              }}</span>
            </span>
          </div>
          <div
            v-else-if="step.status === 'current'"
            @click="step.function()"
            class="flex items-center px-6 py-4 text-sm font-medium cursor-pointer"
            aria-current="step"
          >
            <span
              class="flex h-10 w-10 flex-shrink-0 items-center justify-center rounded-full border-2 border-lime-600"
            >
              <span class="text-lime-600">{{ step.id }}</span>
            </span>
            <span class="ml-4 text-sm font-medium text-lime-600">{{
              step.name
            }}</span>
          </div>
          <div
            v-else
            @click="step.function()"
            class="group flex items-center cursor-pointer"
          >
            <span class="flex items-center px-6 py-4 text-sm font-medium">
              <span
                class="flex h-10 w-10 flex-shrink-0 items-center justify-center rounded-full border-2 border-gray-300 group-hover:border-gray-400"
              >
                <span class="text-gray-500 group-hover:text-gray-900">{{
                  step.id
                }}</span>
              </span>
              <span
                class="ml-4 text-sm font-medium text-gray-500 group-hover:text-gray-900"
                >{{ step.name }}</span
              >
            </span>
          </div>
          <template v-if="stepIdx !== steps.length - 1">
            <!-- Arrow separator for lg screens and up -->
            <div
              class="absolute top-0 right-0 hidden h-full w-5 md:block"
              aria-hidden="true"
            >
              <svg
                class="h-full w-full text-gray-300"
                viewBox="0 0 22 80"
                fill="none"
                preserveAspectRatio="none"
              >
                <path
                  d="M0 -2L20 40L0 82"
                  vector-effect="non-scaling-stroke"
                  stroke="currentcolor"
                  stroke-linejoin="round"
                />
              </svg>
            </div>
          </template>
        </li>
      </ol>
    </nav>

    <div class="mt-8 sm:mx-auto sm:w-full sm:max-w-md">
      <div class="bg-white py-8 px-4 shadow sm:rounded-lg sm:px-10">
        <form @submit.prevent="onSubmit">
          <div class="space-y-6" v-if="currentStep === 1">
            <div>
              <label class="block text-sm font-medium text-gray-700"
                >Username</label
              >
              <div class="mt-1 flex">
                <input
                  type="text"
                  autocomplete="username"
                  v-model="form.username"
                  required
                  class="block w-full mr-5 appearance-none rounded-md border border-gray-300 px-3 py-2 placeholder-gray-400 shadow-sm focus:border-lime-500 focus:outline-none focus:ring-lime-500 sm:text-sm"
                />
                <img
                  class="h-10 w-10 rounded-full cursor-pointer"
                  :src="`/${form.picture}.png`"
                  :key="form.picture"
                  alt=""
                  @click="open = true"
                />
              </div>
            </div>
            <TransitionRoot as="template" :show="open">
              <Dialog as="div" class="relative z-10" @close="open = false">
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
                              >Select your picture</DialogTitle
                            >
                            <div class="mt-2 grid grid-cols-5 gap-1">
                              <img
                                v-for="imageNumber in 5"
                                :key="imageNumber"
                                :src="`/${imageNumber}.png`"
                                class="h-10 w-10 rounded-full cursor-pointer transition-all duration-300 ease-in-out transform hover:scale-105"
                                @click="form.picture = imageNumber"
                                :class="{
                                  'border-2 border-lime-600':
                                    form.picture === imageNumber,
                                }"
                              />
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
            <div>
              <label class="block text-sm font-medium text-gray-700"
                >Email address</label
              >
              <div class="mt-1">
                <input
                  type="email"
                  autocomplete="email"
                  v-model="form.email"
                  required
                  class="block w-full appearance-none rounded-md border border-gray-300 px-3 py-2 placeholder-gray-400 shadow-sm focus:border-lime-500 focus:outline-none focus:ring-lime-500 sm:text-sm"
                />
              </div>
            </div>

            <div>
              <label class="block text-sm font-medium text-gray-700"
                >Password</label
              >
              <div class="mt-1">
                <input
                  type="password"
                  autocomplete="current-password"
                  v-model="form.password"
                  required
                  class="block w-full appearance-none rounded-md border border-gray-300 px-3 py-2 placeholder-gray-400 shadow-sm focus:border-lime-500 focus:outline-none focus:ring-lime-500 sm:text-sm"
                />
              </div>
            </div>

            <div>
              <button
                @click="toStep2"
                type="button"
                class="flex w-full justify-center rounded-md border border-transparent bg-lime-600 py-2 px-4 text-sm font-medium text-white shadow-sm hover:bg-lime-700 focus:outline-none focus:ring-2 focus:ring-lime-500 focus:ring-offset-2"
              >
                Next Step
              </button>
            </div>
          </div>
          <div class="space-y-6" v-if="currentStep === 2">
            <fieldset>
              <legend class="text-base font-semibold leading-6 text-gray-900">
                What are you interested in?
              </legend>
              <div
                class="mt-4 divide-y divide-gray-200 border-t border-b border-gray-200"
              >
                <div
                  v-for="(category, categoryIdx) in categories"
                  :key="categoryIdx"
                  class="relative flex items-start py-4"
                >
                  <div class="min-w-0 flex-1 text-sm">
                    <label
                      :for="`category-${category.id}`"
                      class="select-none font-medium text-gray-700"
                      >{{ category.name }}</label
                    >
                  </div>
                  <div class="ml-3 flex h-5 items-center">
                    <input
                      :id="`category-${category.id}`"
                      :name="`category-${category.id}`"
                      type="checkbox"
                      class="h-4 w-4 rounded border-gray-300 text-lime-600 focus:ring-lime-500"
                      v-model="category.check"
                    />
                  </div>
                </div>
              </div>
            </fieldset>
            <div class="space-y-6">
              <button
                @click="toStep1"
                type="button"
                class="flex w-full justify-center rounded-md border border-transparent bg-red-600 py-2 px-4 text-sm font-medium text-white shadow-sm hover:bg-red-700 focus:outline-none focus:ring-2 focus:ring-red-500 focus:ring-offset-2"
              >
                Back
              </button>
              <button
                @click="toStep3"
                type="button"
                class="flex w-full justify-center rounded-md border border-transparent bg-lime-600 py-2 px-4 text-sm font-medium text-white shadow-sm hover:bg-lime-700 focus:outline-none focus:ring-2 focus:ring-lime-500 focus:ring-offset-2"
              >
                Next Step
              </button>
            </div>
          </div>
          <div class="space-y-6" v-if="currentStep === 3">
            <fieldset v-if="categories[0].check">
              <legend class="text-base font-semibold leading-6 text-gray-900">
                Health
              </legend>
              <div
                class="mt-4 divide-y divide-gray-200 border-t border-b border-gray-200"
              >
                <div
                  v-for="(interest, interestIdx) in health"
                  :key="interestIdx"
                  class="relative flex items-start py-4"
                >
                  <div class="min-w-0 flex-1 text-sm">
                    <label
                      :for="`interest-${interest.id}`"
                      class="select-none font-medium text-gray-700"
                      >{{ interest.name }}</label
                    >
                  </div>
                  <div class="ml-3 flex h-5 items-center">
                    <input
                      :id="`interest-${interest.id}`"
                      :name="`interest-${interest.id}`"
                      :value="interest.id"
                      type="checkbox"
                      class="h-4 w-4 rounded border-gray-300 text-lime-600 focus:ring-lime-500"
                      v-model="form.fiInterest"
                    />
                  </div>
                </div>
              </div>
            </fieldset>
            <fieldset v-if="categories[1].check">
              <legend class="text-base font-semibold leading-6 text-gray-900">
                Tracking
              </legend>
              <div
                class="mt-4 divide-y divide-gray-200 border-t border-b border-gray-200"
              >
                <div
                  v-for="(interest, interestIdx) in tracker"
                  :key="interestIdx"
                  class="relative flex items-start py-4"
                >
                  <div class="min-w-0 flex-1 text-sm">
                    <label
                      :for="`interest-${interest.id}`"
                      class="select-none font-medium text-gray-700"
                      >{{ interest.name }}</label
                    >
                  </div>
                  <div class="ml-3 flex h-5 items-center">
                    <input
                      :id="`interest-${interest.id}`"
                      :name="`interest-${interest.id}`"
                      :value="interest.id"
                      type="checkbox"
                      class="h-4 w-4 rounded border-gray-300 text-lime-600 focus:ring-lime-500"
                      v-model="form.fiInterest"
                    />
                  </div>
                </div>
              </div>
            </fieldset>
            <fieldset v-if="categories[2].check">
              <legend class="text-base font-semibold leading-6 text-gray-900">
                Fitness
              </legend>
              <div
                class="mt-4 divide-y divide-gray-200 border-t border-b border-gray-200"
              >
                <div
                  v-for="(interest, interestIdx) in fitness"
                  :key="interestIdx"
                  class="relative flex items-start py-4"
                >
                  <div class="min-w-0 flex-1 text-sm">
                    <label
                      :for="`interest-${interest.id}`"
                      class="select-none font-medium text-gray-700"
                      >{{ interest.name }}</label
                    >
                  </div>
                  <div class="ml-3 flex h-5 items-center">
                    <input
                      :id="`interest-${interest.id}`"
                      :name="`interest-${interest.id}`"
                      :value="interest.id"
                      type="checkbox"
                      class="h-4 w-4 rounded border-gray-300 text-lime-600 focus:ring-lime-500"
                      v-model="form.fiInterest"
                    />
                  </div>
                </div>
              </div>
            </fieldset>
            <div class="space-y-6">
              <button
                @click="toStep2"
                type="button"
                class="flex w-full justify-center rounded-md border border-transparent bg-red-600 py-2 px-4 text-sm font-medium text-white shadow-sm hover:bg-red-700 focus:outline-none focus:ring-2 focus:ring-red-500 focus:ring-offset-2"
              >
                Back
              </button>
              <button
                @click.prevent="onSubmit"
                type="submit"
                class="flex w-full justify-center rounded-md border border-transparent bg-lime-600 py-2 px-4 text-sm font-medium text-white shadow-sm hover:bg-lime-700 focus:outline-none focus:ring-2 focus:ring-lime-500 focus:ring-offset-2"
              >
                Sign up
              </button>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>
<script setup>
import { CheckIcon } from "@heroicons/vue/24/solid";

import { ref } from "vue";
import axios from "axios";
import { useRouter } from "vue-router";
import {
  Dialog,
  DialogPanel,
  DialogTitle,
  TransitionChild,
  TransitionRoot,
} from "@headlessui/vue";
import interests from "../../interests";
import { useToast } from "vue-toastification";
const router = useRouter();
const toast = useToast();
const toStep1 = () => {
  currentStep.value = 1;
  steps[0].status = "current";
  steps[1].status = "upcoming";
  steps[2].status = "upcoming";
};

const toStep2 = () => {
  currentStep.value = 2;
  steps[0].status = "complete";
  steps[1].status = "current";
  steps[2].status = "upcoming";
};

const toStep3 = () => {
  currentStep.value = 3;
  steps[0].status = "complete";
  steps[1].status = "complete";
  steps[2].status = "current";
};
let currentStep = ref(1);

const open = ref(false);
let steps = [
  { id: "01", name: "Information", function: toStep1, status: "current" },
  {
    id: "02",
    name: "Categories",
    function: toStep2,
    status: "upcoming",
  },
  { id: "03", name: "Interests", function: toStep3, status: "upcoming" },
];
const categories = [
  { id: 1, name: "Health", check: false },
  { id: 2, name: "Tracking", check: false },
  { id: 3, name: "Fitness", check: false },
];
const health = [
  { id: interests[0].id, name: interests[0].name, check: false },
  { id: interests[1].id, name: interests[1].name, check: false },
  { id: interests[2].id, name: interests[2].name, check: false },
  { id: interests[3].id, name: interests[3].name, check: false },
  { id: interests[4].id, name: interests[4].name, check: false },
  { id: interests[5].id, name: interests[5].name, check: false },
];

const tracker = [
  { id: interests[6].id, name: interests[6].name, check: false },
  { id: interests[7].id, name: interests[7].name, check: false },
  { id: interests[8].id, name: interests[8].name, check: false },
  { id: interests[9].id, name: interests[9].name, check: false },
  { id: interests[10].id, name: interests[10].name, check: false },
];

const fitness = [
  { id: interests[11].id, name: interests[11].name, check: false },
  { id: interests[12].id, name: interests[12].name, check: false },
];
const form = ref({
  username: "",
  email: "",
  password: "",
  picture: 1,
  fiInterest: [],
});

const onSubmit = async () => {
  try {
    const response = await axios.post("/signup.php", form.value);
    if (response.data.status == "Success") {
      toast.success(response.data.message);
      router.push("/signin");
    } else {
      toast.error(response.data.message);
      toStep1();
    }
  } catch (error) {
    console.error(error);
  }
};
</script>
