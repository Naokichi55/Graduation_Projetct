const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  theme: {
    extend: {
      colors: {
        green: '#53AD56',
        yellow: '#FFEB3B',
        blue: '#2F6AFF',
        red: '#FF0004',
        navy: '#1E3A8A',
        secondary: '#ecc94b',
        // ...
      },
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
    },
  },
  plugins: [
    // require('@tailwindcss/forms'),
    // require('@tailwindcss/typography'),
    // require('@tailwindcss/container-queries'),
    // require('daisyui')
  ]

}
