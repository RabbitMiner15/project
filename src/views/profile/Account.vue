<template>
  <div class="h-full">
    <main class="mx-auto max-w-7xl pb-10 md:py-12 md:px-8">
      <div class="md:grid md:grid-cols-12 md:gap-x-5">
        <Sidebar />
        <div class="space-y-6 sm:px-6 md:col-span-9 md:px-0">
          <section aria-labelledby="payment-details-heading">
            <form action="#" method="POST">
              <div class="shadow sm:overflow-hidden sm:rounded-md">
                <div class="bg-white py-6 px-4 sm:p-6">
                  <div>
                    <h2
                      id="plan-heading"
                      class="text-lg font-medium leading-6 text-gray-900"
                    >
                      Account
                    </h2>
                  </div>
                  <div class="mt-3 divide-y divide-gray-200">
                    <div>
                      <dl class="divide-y divide-gray-200">
                        <div
                          class="py-4 sm:grid sm:grid-cols-3 sm:gap-4 sm:py-5"
                        >
                          <dt class="text-sm font-medium text-gray-500">
                            Username
                          </dt>
                          <dd
                            class="mt-1 flex text-sm text-gray-900 sm:col-span-2 sm:mt-0"
                          >
                            <span class="flex-grow">{{ userState.user.dtUsername }}</span>
                            <span class="ml-4 flex-shrink-0">
                              <button
                                type="button"
                                class="rounded-md bg-white font-medium text-lime-600 hover:text-lime-500 focus:outline-none focus:ring-2 focus:ring-lime-500 focus:ring-offset-2"
                              >
                                Update
                              </button>
                            </span>
                          </dd>
                        </div>
                        <div
                          class="py-4 sm:grid sm:grid-cols-3 sm:gap-4 sm:py-5 sm:pt-5"
                        >
                          <dt class="text-sm font-medium text-gray-500">
                            Picture
                          </dt>
                          <dd
                            class="mt-1 flex text-sm text-gray-900 sm:col-span-2 sm:mt-0"
                          >
                            <span class="flex-grow">
                              <img
                                class="h-8 w-8 rounded-full"
                                :src="'/' + userState.user.dtPicture + '.png'"
                                alt=""
                              />
                            </span>
                            <span
                              class="ml-4 flex flex-shrink-0 items-start space-x-4"
                            >
                              <button
                                type="button"
                                class="rounded-md bg-white font-medium text-lime-600 hover:text-lime-500 focus:outline-none focus:ring-2 focus:ring-lime-500 focus:ring-offset-2"
                              >
                                Update
                              </button>
                            </span>
                          </dd>
                        </div>
                        <div
                          class="py-4 sm:grid sm:grid-cols-3 sm:gap-4 sm:py-5 sm:pt-5"
                        >
                          <dt class="text-sm font-medium text-gray-500">
                            Email
                          </dt>
                          <dd
                            class="mt-1 flex text-sm text-gray-900 sm:col-span-2 sm:mt-0"
                          >
                            <span class="flex-grow">{{ userState.user.dtEmail }}</span>
                            <span class="ml-4 flex-shrink-0">
                              <button
                                type="button"
                                class="rounded-md bg-white font-medium text-lime-600 hover:text-lime-500 focus:outline-none focus:ring-2 focus:ring-lime-500 focus:ring-offset-2"
                              >
                                Update
                              </button>
                            </span>
                          </dd>
                        </div>
                        <div
                          class="py-4 sm:grid sm:grid-cols-3 sm:gap-4 sm:border-b sm:border-gray-200 sm:py-5"
                        >
                          <dt class="text-sm font-medium text-gray-500">
                            Password
                          </dt>
                          <dd
                            class="mt-1 flex text-sm text-gray-900 sm:col-span-2 sm:mt-0"
                          >
                            <span class="flex-grow">*********</span>
                            <span class="ml-4 flex-shrink-0">
                              <button
                                type="button"
                                class="rounded-md bg-white font-medium text-lime-600 hover:text-lime-500 focus:outline-none focus:ring-2 focus:ring-lime-500 focus:ring-offset-2"
                              >
                                Update
                              </button>
                            </span>
                          </dd>
                        </div>
                      </dl>
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

          <section aria-labelledby="plan-heading">
            <form action="#" method="POST">
              <div class="shadow sm:overflow-hidden sm:rounded-md">
                <div class="space-y-6 bg-white py-6 px-4 sm:p-6">
                  <div>
                    <h2
                      id="plan-heading"
                      class="text-lg font-medium leading-6 text-gray-900"
                    >
                      Connections
                    </h2>
                  </div>
                </div>
              </div>
            </form>
          </section>
          <section aria-labelledby="plan-heading">
            <form action="#" method="POST">
              <div class="shadow sm:overflow-hidden sm:rounded-md">
                <div class="space-y-6 bg-white py-6 px-4 sm:p-6">
                  <div>
                    <h2
                      id="plan-heading"
                      class="text-lg font-medium leading-6 text-gray-900"
                    >
                      Privacy
                    </h2>
                  </div>
                  <SwitchGroup
                    as="div"
                    class="py-4 sm:grid sm:grid-cols-3 sm:gap-4 sm:py-5 sm:pt-5"
                  >
                    <SwitchLabel
                      as="dt"
                      class="text-sm font-medium text-gray-500"
                      passive
                      >Private Account</SwitchLabel
                    >
                    <dd
                      class="mt-1 flex text-sm text-gray-900 sm:col-span-2 sm:mt-0"
                    >
                      <Switch
                        v-model="privateAccount"
                        :class="[
                          privateAccount ? 'bg-lime-600' : 'bg-gray-200',
                          'relative inline-flex h-6 w-11 flex-shrink-0 cursor-pointer rounded-full border-2 border-transparent transition-colors duration-200 ease-in-out focus:outline-none focus:ring-2 focus:ring-lime-500 focus:ring-offset-2 sm:ml-auto',
                        ]"
                      >
                        <span
                          aria-hidden="true"
                          :class="[
                            privateAccount ? 'translate-x-5' : 'translate-x-0',
                            'inline-block h-5 w-5 transform rounded-full bg-white shadow ring-0 transition duration-200 ease-in-out',
                          ]"
                        />
                      </Switch>
                    </dd>
                  </SwitchGroup>
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
          <section aria-labelledby="plan-heading">
            <form action="#" method="POST">
              <div class="shadow sm:overflow-hidden sm:rounded-md">
                <div class="space-y-6 bg-white py-6 px-4 sm:p-6">
                  <div>
                    <h2
                      id="plan-heading"
                      class="text-lg font-medium leading-6 text-gray-900"
                    >
                      Delete Account
                    </h2>
                    <p class="mt-2 max-w-2xl text-sm text-gray-500">Are you sure you want to delete your account?</p>
                  </div>
                </div>
                <div class="bg-gray-50 px-4 py-3 text-right sm:px-6">
                  <button
                    type="submit"
                    class="inline-flex justify-center items-center rounded-md bg-red-600 px-4 py-2 text-sm font-medium text-white shadow-sm hover:bg-red-500"
                  >
                    Delete
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
import Sidebar from "../../components/Sidebar.vue";
import { ref } from "vue";
import { Switch, SwitchGroup, SwitchLabel } from "@headlessui/vue";
import { useUserStore } from "../../store/user";
const userState = useUserStore();
const privateAccount = ref(true);
</script>
