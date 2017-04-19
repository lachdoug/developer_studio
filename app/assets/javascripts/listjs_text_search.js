$(document).on('turbolinks:load', function(){

  if ($('#engines_list_search').length) {
    var install_libarary_apps = new List('engines_list_search', { valueNames: [ 'list_search' ] } );
    $('#engines_list_search input.search').val('');
    $('#engines_list_search input.search').focus();
  };

});
