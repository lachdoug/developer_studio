$(document).on('turbolinks:load', function(){
  $('#engine_blueprint_section_base').show();
  do_blueprint_deployment_type_select($('.blueprint_deployment_type_select_wrapper'));
  $('#engine_blueprint_section_base').hide();
  bind_do_blueprint_deployment_type_select_change_event();
});

var bind_do_blueprint_deployment_type_select_change_event = function() {
  $('.blueprint_deployment_type_select_wrapper').on('change', function(){
    do_blueprint_deployment_type_select(this);
    check_validity_of_all_blueprint_sections();
  })
};

var do_blueprint_deployment_type_select = function(object) {
  if ( $(object).find('select').val() == "worker" ) {
    $(object).next().hide();
  } else {
    $(object).next().show();
  };
};
