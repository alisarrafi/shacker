// Have a little spinner in the corner while loading Ajax requests
Ajax.Responders.register({
  onCreate: function(){
	  $('busy').show();	
  }, 
  onComplete: function(){
	  $('busy').hide();	
  },
	onFailure: function(transport) {
	  $('busy').hide();	
  }
});

// Centers the absolute div for flash messages
function centerflash(id) {
  if (screen && screen.availWidth && $(id) && $('container')) {
    containerleft = $('container').makePositioned().cumulativeOffset($(id)).first();
    containerwidth = $('container').getDimensions()['width'];
    $(id).setStyle({left: (containerleft + (containerwidth - $(id).getDimensions()['width']) / 2) + "px"});
  }
}

// Returns last character of a string
String.prototype.last = function() {
  return this.charAt(this.length-1)
};

// Indicates, whether a character is the highest
String.prototype.is_highest = function() {
  return this == characters.last();
};

// Increments a character by one (returns lowest character if not found)
String.prototype.increment = function() {
  if (this.is_highest()) return characters.first();  // If already highest character, return lowest character
  return characters[characters.indexOf(String(this)) + 1];   // Else, increment character by one
}

// Increments only the last character of a string
String.prototype.increment_last = function() {
  if (this.length == 0) return "";
  if (this.length == 1) return this.increment();
  return this.slice(0, this.length - 1) + this.last().increment();
};

// Increments a chunk according to the given characters
String.prototype.next_chunk = function() {
  var size = this.length
  var last = this.last();
  var is_highest = this.is_highest();
  if (size == 0) {                        // Empty string
    return characters.first();            //   => Lowest character
  } else if (size == 1 && is_highest) {   // Single, highest character
    return characters.first().times(2);   //   => Two-character string with lowest character
  } else if (size == 1 && !is_highest) {  // Single, low character
    return this.increment();              //   => Next higher character
  } else if (!last.is_highest()) {        // String, last character is low
    return this.increment_last();         //   => Increment only last character
  } else {                                // String with last character being the highest
    for (var i=size-2; i>=0; i--) {       //   => Going left for every character
      var at = this.charAt(i)
      if (!at.is_highest()) {                       // If character is low
        one = this.slice(0, i+1).increment_last();  // Take the string up to that character and increment the last character
        return one + characters.first().times(size - one.length)  // Fill the rest of the original string with lowest character
      }
    }
    return characters.first().times(size + 1)  // Every character is highest, add one character and return everything lowest
  }
}
