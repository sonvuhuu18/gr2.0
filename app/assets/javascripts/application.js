// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require holderjs
//= require jquery
//= require bootstrap-sprockets
//= require jquery_ujs
//= require cable
//= require turbolinks
//= require jquery-ui/effect
//= require jquery-ui/effects/effect-highlight
//= require jquery.countdown
//= require_tree .

$(document).on('change', '#user_avatar', function() {
  var input = document.getElementById('user_avatar');
  var item = document.getElementById('image_preview');
  if (input.files && input.files[0])
    item.src = URL.createObjectURL(input.files[0]);
  else {
    item.src = '';
    Holder.run({item});
  }
});

(function() {
  $(document).on('click', '.toggle-window', function(e) {
    e.preventDefault();
    var panel = $(this).parent().parent();
    var messages_list = panel.find('.messages-list');

    panel.find('.conversation-body').toggle();
    panel.attr('class', 'panel panel-default');

    if (panel.find('.conversation-body').is(':visible')) {
      var height = messages_list[0].scrollHeight;
      messages_list.scrollTop(height);
    }
  });
})();

$(document).on('click', '.js-trigger', function() {
  $('.js-trigger').toggleClass('button-transition')
  if ($('.chat').css('right') == '-220px') {
    $('.chat').animate({right: "+=220px"}, 300);
    $('.conversation').animate({right: "+=220px"}, 300);
  }
  else {
    $('.chat').animate({right: "-=220px"}, 300);
    $('.conversation').animate({right: "-=220px"}, 300);
  }
});

var intervalId;
function highlight(element) {
  intervalId = setInterval(function () {
    element.effect("highlight", {}, 1000);
  }, 2000);
}
/*
var highlight = function(element) {
  setInterval(function() {
    element.effect("highlight");
  }, 2000);
};
*/
$(document).on('click', '.conversation__header', function(e) {
  e.preventDefault();
  var chatbox = $(this).parent();
  var messages_list = chatbox.find('.messages-list');
  clearInterval(intervalId);
  chatbox.find('.conversation-body').slideToggle(300);
  if (chatbox.find('.conversation-body').is(':visible')) {
    var height = messages_list[0].scrollHeight;
    messages_list.scrollTop(height);
  }
});

var countdown = function() {
  $('#clock').countdown({
    until: $('#remaining_time').val(),
    format: 'HMS',
    onExpiry: function() {
      alert("Time's up!");
      document.getElementById('submit-button').click();
    }
  });
}

document.addEventListener('turbolinks:load', countdown);
$(document).on('page:update', countdown);
