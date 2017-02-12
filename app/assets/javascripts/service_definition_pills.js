function display_service_definition(service_definition_name) {
  set_service_definition_to_display(service_definition_name);
  set_service_definition_pill(service_definition_name);
};

function set_service_definition_to_display(service_definition_name) {
  $(".service-definition-display").hide();
  $("#service_definition_" + service_definition_name).show();
};

function set_service_definition_pill(service_definition_name) {
  $(".page_section_pill").removeClass('active');
  $("#service_definition_" + service_definition_name + "_pill").addClass('active');
};
