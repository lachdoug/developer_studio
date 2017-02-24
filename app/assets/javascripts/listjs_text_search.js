$(document).on('turbolinks:load', function(){

  if ($('#apps_list_search').length) {
    var install_libarary_apps = new List('apps_list_search', { valueNames: [ 'list_search' ] } );
    $('#apps_list_search input.search').val('');
    $('#apps_list_search input.search').focus();
  };

});
