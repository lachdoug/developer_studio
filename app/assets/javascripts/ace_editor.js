var aceEditor;

var enableAceEditor = function(targetInput) {
  $('body').append($('#ace-editor-template').html());
  $("#ace-editor-container").data("target", targetInput.attr('id'));
  var mode = targetInput.data('mode');
  if (mode == undefined){
    var mode = targetInput.closest('.form-group').prev().find('select').val();
  };
  $('#ace-editor-language-mode-display').text(mode);
  var editor = ace.edit("ace-editor");
  editor.setKeyboardHandler("ace/keyboard/vim");
  editor.getSession().setMode("ace/mode/" + mode);
  var edit_text = targetInput.val();
  if ( edit_text == undefined ) { edit_text = '' };
  editor.setValue(edit_text);
  editor.setOptions({
    fontSize: "14pt"
  });
  editor.focus();
  $("body").addClass('modal-open');
};

var hideAceEditor = function() {
  $("body").removeClass('modal-open');
  $("#ace-editor-container").remove();
};

var updateInputValueWithAceEditorText = function() {
  var codeText = ace.edit("ace-editor").getValue();
  var targetInputId = $("#ace-editor-container").data("target");
  var targetInput = $('#' + targetInputId);
  if ( targetInput.val() != codeText ) {
    targetInput.val(codeText);
    targetInput.prev().text(codeText);
    targetInput.change();
  };
};

$(document).click(function(event) {

  if ( $(event.target).hasClass('custom-form-code-input-show-ace-editor') ) {
    var targetInput = $(event.target).next();
    enableAceEditor(targetInput);
  };

  if ( $(event.target).hasClass('ace-editor-ok') ) {
    updateInputValueWithAceEditorText();
    hideAceEditor();
  };

  if ( $(event.target).hasClass('ace-editor-cancel') ) {
    hideAceEditor();
  };

});

$(document).on('change', function(event) {

  if ( $(event.target).hasClass('ace-editor-language-select') ) {
    var language = $(event.target).val();
    $(event.target).parent().parent().next().find('textarea').data( 'mode', language );
  };

});
