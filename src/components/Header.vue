<template>
  <div class="min-h-full">
    <Disclosure as="nav" class="bg-white shadow-sm" v-slot="{ open }">
      <div class="mx-auto max-w-7xl px-4 sm:px-6 md:px-8">
        <div class="flex h-16 justify-between">
          <div class="flex">
            <div class="flex flex-shrink-0 items-center">
              <router-link to="/">
                <img
                  class="block h-8 w-auto md:hidden cursor-pointer"
                  src="https://tailwindui.com/img/logos/mark.svg?color=lime&shade=600"
                  alt="Fitty"
                />
              </router-link>
              <router-link to="/">
                <img
                  class="hidden h-8 w-auto md:block cursor-pointer"
                  src="https://tailwindui.com/img/logos/mark.svg?color=lime&shade=600"
                  alt="Fitty"
                />
              </router-link>
            </div>
            <div class="hidden sm:-my-px sm:ml-6 sm:flex sm:space-x-8">
              <router-link
                v-for="item in navigation"
                :key="item.name"
                :to="item.href"
                :class="[
                  'border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300',
                  'inline-flex items-center px-1 pt-1 border-b-2 text-sm font-medium',
                ]"
                exact-active-class="bg-lime-50 border-lime-600 text-lime-600"
                :aria-current="item.current ? 'page' : undefined"
                >{{ item.name }}</router-link
              >
            </div>
          </div>
          <div class="hidden sm:ml-6 sm:flex sm:items-center">
            <button
              v-if="userState.user"
              type="button"
              class="rounded-full bg-white p-1 text-gray-400 hover:text-gray-500 focus:outline-none focus:ring-2 focus:ring-lime-600 focus:ring-offset-2"
            ></button>
            <Menu as="div" class="relative ml-3" v-if="userState.user">
              <div>
                <MenuButton
                  class="flex rounded-full bg-white text-sm focus:outline-none focus:ring-2 focus:ring-lime-600 focus:ring-offset-2"
                >
                  <span class="sr-only">View notifications</span>
                  <BellIcon class="h-6 w-6" aria-hidden="true" />
                </MenuButton>
              </div>
              <transition
                enter-active-class="transition ease-out duration-200"
                enter-from-class="transform opacity-0 scale-95"
                enter-to-class="transform opacity-100 scale-100"
                leave-active-class="transition ease-in duration-75"
                leave-from-class="transform opacity-100 scale-100"
                leave-to-class="transform opacity-0 scale-95"
              >
                <MenuItems
                  class="absolute right-0 z-10 mt-2 w-48 origin-top-right rounded-md bg-white py-1 shadow-lg ring-1 ring-black ring-opacity-5 focus:outline-none"
                >
                  <MenuItem v-for="item in notifications" :key="item.name">
                    <p class="['', 'block px-4 py-2 text-sm text-gray-700']">
                      {{ item.name }}
                    </p>
                  </MenuItem>
                </MenuItems>
              </transition>
            </Menu>

            <!-- Profile dropdown -->
            <Menu as="div" class="relative ml-3">
              <div>
                <MenuButton
                  class="flex rounded-full bg-white text-sm focus:outline-none focus:ring-2 focus:ring-lime-600 focus:ring-offset-2"
                >
                  <span class="sr-only">Open user menu</span>
                  <img
                    v-if="userState.user"
                    class="h-8 w-8 rounded-full"
                    :src="'/' + userState.user.dtPicture + '.png'"
                    alt=""
                  />
                  <img
                    v-else
                    class="h-8 w-8 rounded-full"
                    :src="'/' + 5 + '.png'"
                    alt=""
                  />
                </MenuButton>
              </div>
              <transition
                enter-active-class="transition ease-out duration-200"
                enter-from-class="transform opacity-0 scale-95"
                enter-to-class="transform opacity-100 scale-100"
                leave-active-class="transition ease-in duration-75"
                leave-from-class="transform opacity-100 scale-100"
                leave-to-class="transform opacity-0 scale-95"
              >
                <MenuItems
                  v-if="userState.user"
                  class="absolute right-0 z-10 mt-2 w-48 origin-top-right rounded-md bg-white py-1 shadow-lg ring-1 ring-black ring-opacity-5 focus:outline-none"
                >
                  <MenuItem v-for="item in userNavigation" :key="item.name">
                    <router-link
                      :to="item.href"
                      class="block px-4 py-2 text-sm text-gray-700"
                      >{{ item.name }}</router-link
                    >
                  </MenuItem>
                  <MenuItem>
                    <a
                      @click="signOut()"
                      key="signOut"
                      class="block px-4 py-2 text-sm text-gray-700 cursor-pointer"
                      >Sign Out</a
                    >
                  </MenuItem>
                </MenuItems>
                <MenuItems
                  v-else
                  class="absolute right-0 z-10 mt-2 w-48 origin-top-right rounded-md bg-white py-1 shadow-lg ring-1 ring-black ring-opacity-5 focus:outline-none"
                >
                  <MenuItem
                    v-for="item in loggedOutNavigation"
                    :key="item.name"
                  >
                    <router-link
                      :to="item.href"
                      :class="['', 'block px-4 py-2 text-sm text-gray-700']"
                      >{{ item.name }}</router-link
                    >
                  </MenuItem>
                </MenuItems>
              </transition>
            </Menu>
          </div>
          <div class="-mr-2 flex items-center sm:hidden">
            <!-- Mobile menu button -->
            <DisclosureButton
              class="inline-flex items-center justify-center rounded-md bg-white p-2 text-gray-400 hover:bg-gray-100 hover:text-gray-500 focus:outline-none focus:ring-2 focus:ring-lime-600 focus:ring-offset-2"
            >
              <span class="sr-only">Open main menu</span>
              <Bars3Icon
                v-if="!open"
                class="block h-6 w-6"
                aria-hidden="true"
              />
              <XMarkIcon v-else class="block h-6 w-6" aria-hidden="true" />
            </DisclosureButton>
          </div>
        </div>
      </div>

      <DisclosurePanel class="sm:hidden">
        <div class="space-y-1 pt-2 pb-3">
          <router-link
            v-for="item in navigation"
            :key="item.name"
            as="a"
            :to="item.href"
            :class="[
              'border-transparent text-gray-600 hover:bg-gray-50 hover:border-gray-300 hover:text-gray-800',
              'block pl-3 pr-4 py-2 border-l-4 text-base font-medium',
            ]"
            :aria-current="item.current ? 'page' : undefined"
            >{{ item.name }}</router-link
          >
        </div>
        <div class="border-t border-gray-200 pt-4 pb-3">
          <div class="flex items-center px-4" v-if="userState.user">
            <div class="flex-shrink-0">
              <img
                class="h-10 w-10 rounded-full"
                :src="'/' + userState.user.dtPicture + '.png'"
                alt=""
              />
            </div>
            <div class="ml-3">
              <div class="text-base font-medium text-gray-800">
                {{ userState.user.dtUsername }}
              </div>
            </div>
            <button
              type="button"
              class="ml-auto flex-shrink-0 rounded-full bg-white p-1 text-gray-400 hover:text-gray-500 focus:outline-none focus:ring-2 focus:ring-lime-600 focus:ring-offset-2"
            >
              <span class="sr-only">View notifications</span>
              <BellIcon class="h-6 w-6" aria-hidden="true" />
            </button>
          </div>
          <div v-if="userState.user" class="mt-3 space-y-1">
            <router-link
              v-for="item in userNavigation"
              :key="item.name"
              as="a"
              :to="item.href"
              class="block px-4 py-2 text-base font-medium text-gray-500 hover:bg-gray-100 hover:text-gray-800"
              >{{ item.name }}</router-link
            >
            <div
              @click="signOut()"
              key="signOut"
              class="block px-4 py-2 text-base font-medium text-gray-500 hover:bg-gray-100 hover:text-gray-800"
            >
              Sign Out
            </div>
          </div>
          <div v-else class="mt-3 space-y-1">
            <router-link
              v-for="item in loggedOutNavigation"
              :key="item.name"
              as="a"
              :to="item.href"
              class="block px-4 py-2 text-base font-medium text-gray-500 hover:bg-gray-100 hover:text-gray-800"
              >{{ item.name }}</router-link
            >
          </div>
        </div>
      </DisclosurePanel>
    </Disclosure>

    <div class="py-10">
      <main>
        <div class="mx-auto max-w-7xl sm:px-6 md:px-8">
          <slot></slot>
        </div>
      </main>
    </div>
  </div>
</template>

<script setup>
import {
  Disclosure,
  DisclosureButton,
  DisclosurePanel,
  Menu,
  MenuButton,
  MenuItem,
  MenuItems,
} from "@headlessui/vue";
import { Bars3Icon, BellIcon, XMarkIcon } from "@heroicons/vue/24/outline";
import { useUserStore } from "../store/user";
import { useToast } from "vue-toastification";
import { useRouter } from "vue-router";
const toast = useToast();
const userState = useUserStore();
const router = useRouter();
const signOut = () => {
  toast.success("Logged out");
  userState.setUser(null);
  router.push("/");
};
const navigation = [
  { name: "Home", href: "/", current: true },
  { name: "Goals", href: "/goals", current: false },
  { name: "Groups", href: "/groups", current: false },
  { name: "Achievements", href: "/achievements", current: false },
];
const userNavigation = [
  { name: "Your Profile", href: "/profile" },
  { name: "Settings", href: "/settings" },
];
const loggedOutNavigation = [
  { name: "Sign In", href: "/signin" },
  { name: "Sign Up", href: "/signup" },
];
const notifications = [
  { name: "Here is your weekly report" },
  { name: "Added to new group" },
];
</script>
