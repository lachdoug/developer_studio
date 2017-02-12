$(document).ajaxComplete(function(){
  hide_saving_alert();
  bind_autosubmit_forms_input_change_events();
});

$(document).on('turbolinks:load', function(){
  bind_autosubmit_forms_input_change_events();
});

var hide_saving_alert = function() {
  setTimeout(function(){
    $('#saving-alert').fadeOut(100);
  }, 500);
};

var submit_autosubmit_form = function(form_element){
  var form = $(form_element).closest('form');
  if (form.valid()){
    $('#saving-alert').show();
    form.submit();
  };
};

var bind_autosubmit_forms_input_change_events = function() {
  $('form.autosubmit input').off('change');
  $('form.autosubmit input:not(.do_not_autosubmit_form_on_change)').on('change', function(){
    submit_autosubmit_form(this);
  });
  $('input.service_configuration_variable_resolve_checkbox').on('change', function() {
    show_app_blueprint_service_configurations_service_configuration_variable_input_for(this);
  });
  $('form.autosubmit select').off('change');
  $('form.autosubmit select:not(.do_not_autosubmit_form_on_change)').on('change', function(){
    submit_autosubmit_form(this);
  });
  $('form.autosubmit textarea').off('change');
  $('form.autosubmit textarea:not(.do_not_autosubmit_form_on_change)').on('change', function(){
    console.log('hi');
    submit_autosubmit_form(this);
  });
};
