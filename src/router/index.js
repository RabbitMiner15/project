import { createRouter, createWebHistory } from "vue-router";

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: "/",
      name: "home",
      component: () => import("../views/Home.vue"),
    },
    {
      path: "/tos",
      name: "tos",
      component: () => import("../views/footer/TOS.vue"),
    },
    {
      path: "/policy",
      name: "policy",
      component: () => import("../views/footer/Policy.vue"),
    },
    {
      path: "/auth/success",
      name: "authSuccess",
      component: () => import("../views/auth/Success.vue"),
    },
    {
      path: "/about",
      name: "about",
      component: () => import("../views/footer/About.vue"),
    },
    {
      path: "/faq",
      name: "faq",
      component: () => import("../views/footer/FAQ.vue"),
    },
    {
      path: "/profile",
      name: "profile",
      component: () => import("../views/profile/Profile.vue"),
    },
    {
      path: "/profile/settings",
      name: "settings",
      component: () => import("../views/profile/Settings.vue"),
    },
    {
      path: "/contact",
      name: "contact",
      component: () => import("../views/footer/Contact.vue"),
    },







    {
      path: "/:catchAll(.*)",
      name: "404Page",
      component: () => import("../views/404Page.vue"),
    },
  ],
  linkActiveClass: "bg-indigo-50 border-indigo-500 text-indigo-700",
});

export default router;
