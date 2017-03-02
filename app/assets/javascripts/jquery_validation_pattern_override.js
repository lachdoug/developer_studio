var patternErrorMessageFunc = function( value, element, param ) {
  var elementErrorMsg = element.getAttribute('pattern_validation_error_message');
  if (elementErrorMsg) {
    return elementErrorMsg
  } else {
    return "Invalid format."
  };
}

$.validator.addMethod( "pattern", function( value, element, param ) {
	if ( this.optional( element ) ) {
		return true;
	}
	if ( typeof param === "string" ) {
		param = new RegExp( "^(?:" + param + ")$" );
	}
	return param.test( value );
}, patternErrorMessageFunc );
