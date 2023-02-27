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
      path: "/goals",
      name: "goals",
      component: () => import("../views/Goals.vue"),
    },
    {
      path: "/achievements",
      name: "achievements",
      component: () => import("../views/Achievements.vue"),
    },
    {
      path: "/Groups",
      name: "groups",
      component: () => import("../views/Groups.vue"),
    },
    {
      path: "/groups/:id",
      name: "groupId",
      component: () => import("../views/GroupId.vue"),
    },





    {
      path: "/account",
      name: "Account",
      component: () => import("../views/profile/Account.vue"),
    },
    {
      path: "/profile",
      name: "profile",
      component: () => import("../views/profile/Profile.vue"),
    },
    {
      path: "/settings",
      name: "settings",
      component: () => import("../views/profile/Settings.vue"),
    },
    {
      path: "/signup",
      name: "signup",
      component: () => import("../views/profile/SignUp.vue"),
    },
    {
      path: "/signin",
      name: "signin",
      component: () => import("../views/profile/SignIn.vue"),
    },
    {
      path: "/profile/:id",
      name: "profileId",
      component: () => import("../views/profile/ProfileId.vue"),
    },







    {
      path: "/contact",
      name: "contact",
      component: () => import("../views/footer/Contact.vue"),
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
      path: "/:catchAll(.*)",
      name: "404Page",
      component: () => import("../views/404Page.vue"),
    },
  ]
});

export default router;
