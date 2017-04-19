function display_blueprint_section(section_name) {
  set_engine_blueprint_section_to_display(section_name);
  set_engine_blueprint_section_pill(section_name);
  set_engine_blueprint_collapsed_nav_text(section_name);
};

function set_engine_blueprint_section_to_display(section_name) {
  $(".engine_blueprint_section").hide();
  $("#engine_blueprint_section_" + section_name).show();
};

function set_engine_blueprint_section_pill(section_name) {
  $(".page_section_pill").removeClass('active');
  $("#engine_blueprint_section_" + section_name + "_pill").addClass('active');
};

function set_engine_blueprint_collapsed_nav_text(section_name) {
  var text = $("#engine_blueprint_section_" + section_name + "_pill a").text();
  $("#engine_blueprint .navbar-header .navbar-toggle .nav_menu_text").text(text);
};
