$(document).ajaxComplete(function(){
  do_blueprint_section_forms();
});

$(document).on('turbolinks:load', function(){
  do_blueprint_section_forms();
});

var do_blueprint_section_forms = function() {
  check_validity_of_all_blueprint_section_forms();
  bind_blueprint_section_forms_input_change_events();
  do_variable_resolve_checkbox_inputs();
};

var auto_submit_blueprint_section_form = function(form_element){
  var section_form = $(form_element).closest('form');
  if (check_blueprint_section_form_is_valid( section_form )){
    $('#saving-alert').show();
    section_form.submit();
  };
};

var check_validity_of_all_blueprint_section_forms = function() {
  $('.page_section_pill').each(function(){
    var section_pill = $(this);
    var section_id = section_pill.attr('id');
    check_validity_of_blueprint_section_pill( section_pill );
  });
};

// var check_validity_of_active_blueprint_section_forms = function() {
//   var section_pill = $(".page_section_pill.active");
//   check_validity_of_blueprint_section_pill(section_pill);
// };

var check_validity_of_blueprint_section_pill = function(section_pill) {
  var section_id = section_pill.attr('id').replace('_pill', '');
  if (section_pill.hasClass('active')) {
    check_validity_of_blueprint_section(section_id, section_pill);
  } else {
    var section_form_display_area = $('#' + section_id)
    section_form_display_area.show();
    check_validity_of_blueprint_section(section_id, section_pill);
    section_form_display_area.hide();
  };
};

var check_validity_of_blueprint_section = function(section_id, section_pill) {
  var section_forms_selector = '#' + section_id + ' form';
  var section_valid = true;
  $(section_forms_selector).each(function(){
    var section_form = $(this);
    if (!check_blueprint_section_form_is_valid( section_form )){
      section_valid = false;
    };
  });
  if (section_valid) {
    hide_pill_error_warning_for(section_pill);
  } else {
    show_pill_error_warning_for(section_pill);
  };
};

var check_blueprint_section_form_is_valid = function(section_form) {
  section_form.validate();
  if (section_form.valid() && blueprint_section_form_has_no_custom_errors(section_form)) {
    return true;
  } else {
    return false;
  };
};

var blueprint_section_form_has_no_custom_errors = function(section_form) {
  return ( section_form.find(".app_blueprint_section_custom_error").length == 0 );
};

var hide_pill_error_warning_for = function(section_pill) {
  section_pill.find('.pill_error').hide();
};

var show_pill_error_warning_for = function(section_pill) {
  section_pill.find('.pill_error').show();
};

var bind_blueprint_section_forms_input_change_events = function() {
  $('#app_blueprint input').off('change');
  $('#app_blueprint input:not(.do_not_autosubmit_form_on_change)').on('change', function(){
    auto_submit_blueprint_section_form(this);
  });
  $('input.variable_resolve_checkbox_input').on('change', function() {
    show_variable_input_for(this);
  });
  $('#app_blueprint select').off('change');
  $('#app_blueprint select:not(.do_not_autosubmit_form_on_change)').on('change', function(){
    auto_submit_blueprint_section_form(this);
  });
  $('#app_blueprint textarea').off('change');
  $('#app_blueprint textarea:not(.do_not_autosubmit_form_on_change)').on('change', function(){
    auto_submit_blueprint_section_form(this);
  });
};

var do_variable_resolve_checkbox_inputs = function() {
  $('input.variable_resolve_checkbox_input').each(function() {
    show_variable_input_for(this);
  });
};

var show_variable_input_for = function(resolve_checkbox) {
  if (resolve_checkbox.checked) {
    $(resolve_checkbox).parents('.form-group').prevAll('.variable_resolve_string_input_wrapper').show();
    $(resolve_checkbox).parents('.form-group').prevAll('.variable_value_input_wrapper').hide();
  } else {
    $(resolve_checkbox).parents('.form-group').prevAll('.variable_resolve_string_input_wrapper').hide();
    $(resolve_checkbox).parents('.form-group').prevAll('.variable_value_input_wrapper').show();
  };
};
