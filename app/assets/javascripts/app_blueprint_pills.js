function display_blueprint_section(section_name) {
  set_app_blueprint_section_to_display(section_name);
  set_page_section_pill(section_name);
};

function set_app_blueprint_section_to_display(section_name) {
  $(".main-page-col-section").hide();
  $("#app_blueprint_section_" + section_name).show();
};

function set_page_section_pill(section_name) {
  $(".page_section_pill").removeClass('active');
  $("#app_blueprint_section_" + section_name + "_pill").addClass('active');
};
