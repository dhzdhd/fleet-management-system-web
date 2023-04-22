/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./src/**/*.{html,svelte}",
    "./src/*.{html,svelte}",
    "./index.html",
  ],
  theme: {
    extend: {},
  },
  plugins: [require("daisyui")],
};
