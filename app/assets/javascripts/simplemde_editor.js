var simplemdeEditor;

var enableSimplemdeEditor = function(targetInput) {
  $('body').append($('#simplemde-editor-template').html());
  $("#simplemde-editor-container").data("target", targetInput.attr('id'));
  simplemdeEditor = new SimpleMDE({ element: $("#simplemde-editor")[0] });
  simplemdeEditor.value(targetInput.val());
  $('.cm-s-paper textarea').focus();
  $("body").addClass('modal-open');
};

var hideSimplemdeEditor = function() {
  $("body").removeClass('modal-open');
  $("#simplemde-editor-container").remove();
};

var updateInputValueWithSimplemdeEditorText = function() {
  var markdownText = simplemdeEditor.value();
  var targetInputId = $("#simplemde-editor-container").data("target");
  var targetInput = $('#' + targetInputId);
  if ( targetInput.val() != markdownText ) {
    targetInput.val(markdownText);
    var rendered_html = simplemdeEditor.options.previewRender(markdownText);
    targetInput.prev().find('.rendered_html').html(rendered_html);
    targetInput.change();
  };
};

$(document).click(function(event) {

  if ( $(event.target).hasClass('custom-form-markdown-input-show-simplemde-editor') ) {
    var targetInput = $(event.target).next();
    enableSimplemdeEditor(targetInput);
  };

  if ( $(event.target).hasClass('simplemde-editor-ok') ) {
    updateInputValueWithSimplemdeEditorText();
    hideSimplemdeEditor();
  };

  if ( $(event.target).hasClass('simplemde-editor-cancel') ) {
    hideSimplemdeEditor();
  };

});
