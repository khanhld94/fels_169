// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require bootstrap
function timeOut() {
  $('#hidden_status').val('finished');
  $('.edit_lesson').submit();
  document.getElementById('time_lesson').innerHTML = 0;
}

function submit_test() {
  $('#hidden_status').val('finished');
}

function startTimer(time_created, display) {
  var timer = time_created, minutes, seconds;
  setInterval(function () {
    minutes = parseInt(timer / 60, 10);
    seconds = parseInt(timer % 60, 10);

    minutes = minutes < 10 ? '0' + minutes : minutes;
    seconds = seconds < 10 ? '0' + seconds : seconds;

    display.textContent = minutes + ':' + seconds;

    if (--timer < 0) {
      timer = 0;
      timeOut();
    }
  }, 1000);
}

var countdown = function () {
  var value = document.getElementById('time_lesson').innerHTML;
  var display = document.querySelector('#time_lesson');
  startTimer(value, display);
};

document.addEventListener('turbolinks:load', countdown);
$(document).on('page:update', countdown);

window.onload = function () {
  var value = document.getElementById('time_lesson').innerHTML;
  var display = document.querySelector('#time_lesson');
  startTimer(value, display);
};

var array_id = new Array();

function set_number(id) {
  if (check(id) == false) {
    var value = document.getElementById('number_of_checked').innerHTML;
    value++;
    document.getElementById('number_of_checked').innerHTML = value;
  }
}

function check(id) {
  for (var i = 0; i < array_id.length; i++) {
    if(array_id[i] == id)
      return true;
  }
  array_id.push(id);
  return false;
}
