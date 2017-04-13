$(document).on('turbolinks:load', function(){
  bind_show_saving_spinner();
});

$(document).ajaxComplete(function(){
  bind_show_saving_spinner();
});

var bind_show_saving_spinner = function() {
  $('.show_saving_spinner_on_click').on('click', function(){
    $('#saving-alert').show();
  });
  $('.show_saving_spinner_on_confirmed').on('confirm:complete', function(e, answer){
    if (answer) {
      $('#saving-alert').show();
    };
  });
};
