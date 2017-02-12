// Enable jquery form validation

$(document).on('turbolinks:load', function(){
  $("form").validate();
});

$(document).ajaxComplete(function(){
  $("form").validate();
});
