$(document).ajaxError(function(event, request, settings, error) {
  var remotipart_submitted, response;
  response = request.responseText;
  if (request.status === 401 || request.status === 500 || request.status === 404) {
    $('.modal').modal('hide');
    if (request.status === 401) {
      alert(response);
      location.reload();
    } else {
      alert(response);
      location.reload();
    }
  } else if (request.status === 0) {
    if (settings.data && settings.data.constructor.name === 'Array') {
      remotipart_submitted = settings.data.find(function(datum) {
        return datum.name === 'remotipart_submitted';
      });
      if (remotipart_submitted.constructor.name === 'Object') {
        if (remotipart_submitted.value === true) {
          // Do nothing
        } else {
          console.log('Communication error. Ajax status 0. Settings data constructor Array.');
        }
      }
    } else {
      console.log('Communication error. Ajax status 0.');
      location.reload();
    }
  } else {
    console.log("Unhandled ajax error.\nRequest status: " + request.status + "\nError: " + error + "\nResponse: " + response);
    location.reload();
  }
});
