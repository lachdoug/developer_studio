// $(document).ajaxComplete(function(){
//   setTimeout(function(){
//     $('#saving-alert').fadeOut();
//   }, 500);
//   bind_readme_and_release_notes_forms_auto_submit_on_input_change();
// });
//
// $(document).on('turbolinks:load', function(){
//   bind_readme_and_release_notes_forms_auto_submit_on_input_change();
// });
//
//
// var auto_submit_form = function(form_element){
//   var section_form = $(form_element).closest('form');
//   $('#saving-alert').show();
//   section_form.submit();
// };
//
// var bind_readme_and_release_notes_forms_auto_submit_on_input_change = function() {
//   $('#app_readme textarea').off('change');
//   $('#app_readme textarea').on('change', function(){
//     auto_submit_form(this);
//   });
//   $('#app_release_notes textarea').off('change');
//   $('#app_release_notes textarea').on('change', function(){
//     auto_submit_form(this);
//   });
// }
