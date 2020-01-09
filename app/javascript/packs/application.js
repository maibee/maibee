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
import './homepage'

// footer置底
// document.addEventListener("turbolinks:load", ()=>{
//     document.querySelector("footer").classList.remove('bottom_footer');
//     if (document.querySelector('main').offsetHeight < screen.height) {
//         document.querySelector("footer").classList.add('bottom_footer');
//     }
// }, false);
