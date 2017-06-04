$(document).ajaxComplete(function(){
  do_blueprint_section_forms();
});

$(document).on('turbolinks:load', function(){
  do_blueprint_deployment_type_select();
  do_blueprint_framework_select();
  do_blueprint_section_forms();
});

var do_blueprint_deployment_type_select = function(){
  $('#engine_blueprint_section_base').show();
  blueprint_deployment_type_select_depend_on($('.blueprint_deployment_type_select_wrapper select'));
  $('#engine_blueprint_section_base').hide();
};

var blueprint_deployment_type_select_depend_on = function(select_object) {
  if ( $(select_object).val() == "worker" ) {
    $(select_object).closest('.blueprint_deployment_type_select_wrapper').next().hide();
  } else {
    $(select_object).closest('.blueprint_deployment_type_select_wrapper').next().show();
  };
};


var do_blueprint_framework_select = function(){
  $('#engine_blueprint_section_base').show();
  blueprint_framework_select_depend_on($('.blueprint_framework_select_wrapper select'));
  $('#engine_blueprint_section_base').hide();
};

var blueprint_framework_select_depend_on = function(select_object) {
  if ( $(select_object).val() != "docker" ) {
    $(select_object).closest('.blueprint_framework_select_wrapper').next().hide();
  } else {
    $(select_object).closest('.blueprint_framework_select_wrapper').next().show();
  };
};

var do_blueprint_section_forms = function() {
  check_validity_of_all_blueprint_sections();
  bind_blueprint_section_forms_input_change_events();
  do_variable_resolve_checkbox_inputs();
};

var auto_submit_blueprint_section_form = function(form_element){
  var section_form = $(form_element).closest('form');
  if (check_blueprint_section_form_is_valid( section_form )){
    $('#saving-alert').show();
    section_form.submit();
  } else {
    check_validity_of_all_blueprint_sections();
  };
};

var check_validity_of_all_blueprint_sections = function() {
  $('.page_section_pill').each(function(){
    var section_pill = $(this);
    var section_id = section_pill.attr('id');
    check_validity_of_blueprint_section_pill(section_pill);
  });
};

var check_validity_of_blueprint_section_pill = function(section_pill) {
  var section_id = section_pill.attr('id').replace('_pill', '');
  if (section_pill.hasClass('active')) {
    check_validity_of_blueprint_section(section_id, section_pill);
  } else {
    // forms need to be shown to validate
    var section_form_display_area = $('#' + section_id)
    section_form_display_area.show();
    check_validity_of_blueprint_section(section_id, section_pill);
    section_form_display_area.hide();
  };
};

var check_validity_of_blueprint_section = function(section_id, section_pill) {
  var section_forms_selector = '#' + section_id + ' form';
  var nested_section_forms = [];
  var unnested_section_forms = [];
  $(section_forms_selector).each(function(){
    var section_form = $(this);
    var nested_section = section_form.closest('.blueprint_section_collapse_area_nested');
    if ( nested_section.length ) {
      nested_section_forms.push(section_form);
    } else {
      unnested_section_forms.push(section_form);
    };
  });
  do_nested_blueprint_section_forms(nested_section_forms, section_pill);
  do_unnested_blueprint_section_forms(unnested_section_forms, section_pill);
};

var do_unnested_blueprint_section_forms = function(section_forms, section_pill) {
  var section_valid = true;
  section_forms.forEach(function(section_form){
    collapsed_form_visible_for_valitation( section_form );
    if (check_blueprint_section_form_is_valid( section_form )) {
      section_form.closest('.blueprint_item_collapse_area').find('.blueprint_item_collapse').first().removeClass('error');
    } else {
      section_form.closest('.blueprint_item_collapse_area').find('.blueprint_item_collapse').first().addClass('error');
      section_valid = false;
    };
    remove_collapsed_form_visible_for_valitation( section_form );
  });
  if (section_valid) {
    hide_pill_error_warning_for(section_pill);
  } else {
    show_pill_error_warning_for(section_pill);
  };
};

var do_nested_blueprint_section_forms = function(section_forms) {
  section_forms.forEach(function(section_form){
    collapsed_form_visible_for_valitation( section_form );
    if ( check_blueprint_section_form_is_valid( section_form ) ) {
      section_form.closest('.blueprint_item_collapse_area').find('.blueprint_item_collapse').first().removeClass('error');
      do_nested_blueprint_item_collapse_area_errors(section_form, true);
    } else {
      section_form.closest('.blueprint_item_collapse_area').find('.blueprint_item_collapse').first().addClass('error');
      do_nested_blueprint_item_collapse_area_errors(section_form, false);
    };
    remove_collapsed_form_visible_for_valitation( section_form );
  });
};

var collapsed_form_visible_for_valitation = function(section_form){
  section_form.parents('.collapse').addClass('visible_for_validation');
};

var remove_collapsed_form_visible_for_valitation = function(section_form){
  section_form.parents('.collapse').removeClass('visible_for_validation');
};

var check_blueprint_section_form_is_valid = function(section_form) {
  section_form.validate();
  if ( section_form.valid() && blueprint_section_form_has_no_custom_errors(section_form) ) {
    return true;
  } else {
    return false;
  };
};

var blueprint_section_form_has_no_custom_errors = function(section_form) {
  return ( $(section_form).find(".engine_blueprint_section_custom_error").length == 0 );
};

var do_nested_blueprint_item_collapse_area_errors = function(section_form, is_valid) {
  var nested_section = section_form.closest('.blueprint_section_collapse_area_nested');
  if ( is_valid ) {
    $('#' + nested_section.data('target')).removeClass('engine_blueprint_section_custom_error');
  } else {
    $('#' + nested_section.data('target')).addClass('engine_blueprint_section_custom_error');
  };
};

var hide_pill_error_warning_for = function(section_pill) {
  section_pill.find('.pill_error').hide();
};

var show_pill_error_warning_for = function(section_pill) {
  section_pill.find('.pill_error').show();
};

var bind_blueprint_section_forms_input_change_events = function() {
  $('#engine_blueprint input').off('change');
  $('#engine_blueprint select').off('change');
  $('#engine_blueprint textarea').off('change');

  $('.blueprint_framework_select_wrapper select').on('change', function(){
    blueprint_framework_select_depend_on(this);
    check_validity_of_all_blueprint_sections();
  });
  $('.blueprint_deployment_type_select_wrapper select').on('change', function(){
    blueprint_deployment_type_select_depend_on(this);
    check_validity_of_all_blueprint_sections();
  });
  $('#engine_blueprint input:not(.do_not_autosubmit_form_on_change)').on('change', function(){
    auto_submit_blueprint_section_form(this);
  });
  $('input.variable_resolve_checkbox_input').on('change', function() {
    show_variable_input_for(this);
  });
  $('#engine_blueprint select:not(.do_not_autosubmit_form_on_change)').on('change', function(){
    auto_submit_blueprint_section_form(this);
  });
  $('#engine_blueprint textarea:not(.do_not_autosubmit_form_on_change)').on('change', function(){
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
