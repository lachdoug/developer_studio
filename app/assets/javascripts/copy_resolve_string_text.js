function copyResolveStringToPreviousInput(button) {

  var input = $(button).parents('.dropdown').prev().find('input');
  input.val( input.val() + button.textContent );
  input.change();

}

function copyResolveStringToAceEditor(button) {

  var editor = ace.edit("ace-editor");
  editor.session.insert(editor.getCursorPosition(), button.textContent)

}
