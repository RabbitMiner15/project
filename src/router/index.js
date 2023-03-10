import { createRouter, createWebHistory } from "vue-router";

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: "/",
      component: () => import("../views/Home.vue"),
    },
    {
      path: "/goals",
      component: () => import("../views/Goals.vue"),
    },
    {
      path: "/achievements",
      component: () => import("../views/Achievements.vue"),
    },
    {
      path: "/Groups",
      component: () => import("../views/Groups.vue"),
    },
    {
      path: "/groups/:id",
      component: () => import("../views/GroupId.vue"),
    },

    {
      path: "/account",
      component: () => import("../views/profile/Account.vue"),
    },
    {
      path: "/profile",
      component: () => import("../views/profile/Profile.vue"),
    },
    {
      path: "/settings",
      component: () => import("../views/profile/Settings.vue"),
    },
    {
      path: "/signup",
      component: () => import("../views/profile/SignUp.vue"),
    },
    {
      path: "/signin",
      component: () => import("../views/profile/SignIn.vue"),
    },
    {
      path: "/profile/:id",
      component: () => import("../views/profile/ProfileId.vue"),
    },

    {
      path: "/contact",
      component: () => import("../views/footer/Contact.vue"),
    },
    {
      path: "/tos",
      component: () => import("../views/footer/TOS.vue"),
    },
    {
      path: "/policy",
      component: () => import("../views/footer/Policy.vue"),
    },
    {
      path: "/auth/success",
      component: () => import("../views/auth/Success.vue"),
    },
    {
      path: "/about",
      component: () => import("../views/footer/About.vue"),
    },
    {
      path: "/faq",
      component: () => import("../views/footer/FAQ.vue"),
    },

    {
      path: "/:catchAll(.*)",
      component: () => import("../views/404Page.vue"),
    },
  ],
});

export default router;
