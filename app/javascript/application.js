// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import Rails from "@rails/ujs"
import "@hotwired/turbo-rails"
import "controllers"
import "custom/menu"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
//= require jquery
//= require jquery_ujs
//= require_tree .
require("chartkick")
require("chart.js")

Rails.start()
  // Turbolinks.start()
ActiveStorage.start()
  import "controllers"