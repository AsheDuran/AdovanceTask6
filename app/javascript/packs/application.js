// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "jquery"
import "popper.js"
import "bootstrap"
import '@fortawesome/fontawesome-free/js/all';
import "../stylesheets/application"
// import "jquery_ujs"//非同期機能追加時に追加

Rails.start()
Turbolinks.start()
ActiveStorage.start()
// window.$ = window.jQuery = require('jquery');//5段階評価を実装時に追記
require("chartkick") // 追記課題8b
require("chart.js") // 追記課題8b