<template>
  <div class="flex min-h-full flex-col justify-center py-12 sm:px-6 md:px-8">
    <div class="sm:mx-auto sm:w-full sm:max-w-md">
      <img
        class="mx-auto h-12 w-auto"
        src="https://tailwindui.com/img/logos/mark.svg?color=lime&shade=600"
        alt="Your Company"
      />
      <h2
        class="mt-6 text-center text-3xl font-bold tracking-tight text-gray-900"
      >
        Sign in to your account
      </h2>
      <p class="mt-2 text-center text-sm text-gray-600">
        Or
        {{ " " }}
        <router-link
          to="/signup"
          class="font-medium text-lime-600 hover:text-lime-500"
          >create a new one</router-link
        >
      </p>
    </div>

    <div class="mt-8 sm:mx-auto sm:w-full sm:max-w-md">
      <div class="bg-white py-8 px-4 shadow sm:rounded-lg sm:px-10">
        <form class="space-y-6" @submit.prevent="onSubmit">
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

          <div class="flex items-center">
            <div class="text-sm">
              <a href="#" class="font-medium text-lime-600 hover:text-lime-500"
                >Forgot your password?</a
              >
            </div>
          </div>

          <div>
            <button
              type="submit"
              class="flex w-full justify-center rounded-md border border-transparent bg-lime-600 py-2 px-4 text-sm font-medium text-white shadow-sm hover:bg-lime-700 focus:outline-none focus:ring-2 focus:ring-lime-500 focus:ring-offset-2"
            >
              Sign in
            </button>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>
<script setup>
import { ref } from "vue";
import { useRouter } from "vue-router";
import axios from "axios";
import { useToast } from "vue-toastification";
import { useUserStore } from "../../store/user";
const { setUser } = useUserStore();
const toast = useToast();
const form = ref({
  email: "",
  password: "",
});
const router = useRouter();

const onSubmit = async () => {
  try {
    const response = await axios.post("/signin.php", form.value);
    if (response.data.status == "Success") {
      toast.success(
        response.data.message + " " + response.data.data.dtUsername
      );
      setUser(response.data.data);
      router.push("/");
    } else {
      toast.error(response.data.message);
    }
  } catch (error) {
    console.error(error);
  }
};
</script>
