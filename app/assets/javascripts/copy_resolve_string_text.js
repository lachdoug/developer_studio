function copyResolveString(button) {

  var input = $(button).parents('.dropdown').prev().find('input');
  input.val( input.val() + button.textContent );
  input.change();

}
