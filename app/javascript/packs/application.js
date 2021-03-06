// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

require.context('../images', true)

import 'bootstrap/dist/js/bootstrap.js'
import '@fortawesome/fontawesome-free/css/all.css'
import 'styles/full_site.scss'
import 'styles/custom.scss'
import '../zeroing'
import 'chart.js'

document.addEventListener('turbolinks:load',function(){
  new Chart(document.getElementById("chart-SPQ"), {
    type: 'line',
    data: {
      labels: chart_label,
      datasets: currencies_data
    },
  });
})
