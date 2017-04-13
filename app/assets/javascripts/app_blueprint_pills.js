function display_blueprint_section(section_name) {
  set_app_blueprint_section_to_display(section_name);
  set_app_blueprint_section_pill(section_name);
  set_app_blueprint_collapsed_nav_text(section_name);
};

function set_app_blueprint_section_to_display(section_name) {
  $(".app_blueprint_section").hide();
  $("#app_blueprint_section_" + section_name).show();
};

function set_app_blueprint_section_pill(section_name) {
  $(".page_section_pill").removeClass('active');
  $("#app_blueprint_section_" + section_name + "_pill").addClass('active');
};

function set_app_blueprint_collapsed_nav_text(section_name) {
  var text = $("#app_blueprint_section_" + section_name + "_pill a").text();
  $("#app_blueprint .navbar-header .navbar-toggle .nav_menu_text").text(text);
};
