import { createApp } from "vue";
import App from "./App.vue";
import router from "./router";
import "./assets/tailwind.css";

import Toast from "vue-toastification";
import "vue-toastification/dist/index.css";

const options = {
  timeout: 3000,
  position: "bottom-center",
  newestOnTop: true,
  closeOnClick: true,
  pauseOnFocusLoss: true,
  pauseOnHover: true,
  draggable: true,
  draggablePercent: 0.6,
  showCloseButtonOnHover: false,
  hideProgressBar: false,
  closeButton: "button",
  icon: true,
  rtl: false,
};

const app = createApp(App);

app.use(router);
app.use(Toast, options);
app.mount("#app");
