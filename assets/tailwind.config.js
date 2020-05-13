module.exports = {
  purge: ["./lib/**/*.eex", "./lib/**/*.leex", "./lib/**/*.html"],
  theme: {
    extend: {},
  },
  variants: {},
  plugins: [require("@tailwindcss/ui")],
};
