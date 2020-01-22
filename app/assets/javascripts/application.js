// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require bootstrap-sprockets
//= require_tree .

$(document).on('turbolinks:load', function(){
    $('.edit-button').on('click',function(){
      var parent = $(this).parent().parent();
      parent.find('.edit-button').addClass('none-active');
      parent.find('.submit-button').removeClass('none-active');
      parent.find('.genre-text').addClass('none-active');
      parent.find('.genre-form').removeClass('none-active').focus();
      return false;
    });
});


$("document").ready(function() {
    $(".theTarget").skippr({
      transition: 'slide',
      autoPlay: true,
    });
});


$(function () {
    $('#upbtn dt').click(function () {
        $('#signup').show();
        $('#signin').hide();
    });
});

$(function () {
    $('#inbtn dt').click(function () {
        $('#signup').hide();
        $('#signin').show();
    });
});

