var secret
var characters = []
var chunks = []

function shack() {
  chunks.each(function(chunk) {
    if (secret == SHA256(chunk)) {
      return report(chunk);
    }
    /*
    string = "<" + chunk + ">  " + SHA256(chunk) + "<br/>";
    console.log(string);
    $('result').insert(string); 
    $('chunks').update(chunk);
    */    
  });
}

//alert('I found it: ' + password);


function increment_chunk(chunk) {
  var size = chunk.length
  var last = chunk.last;
  if (is_highest_character(last)) {
    if (size == 1) {
      console.log("Chunk is only one character and is highest, return two-character chunk");
      return characters.first().times(2);
    }
    console.log("Chunk needs to be normalized");
    
    
    for (var i = size - 1; i >= 0; i--){
      
    };
  
    return 'oops';
    
  } else {
    if (size == 1) {
      console.log("Chunk is only one low character, increment it");
      return chunk.increment();
    } else {
      console.log("Just increment the last character of this chunk");
      return  
    }
  }
  
}

function increment_character(character) {
  if (is_highest_character(character)) return characters.first();  // If already highest character, return lowest character
  return characters[characters.indexOf(character) + 1];            // Else, increment character by one
}

function is_highest_character(character) {
  return character == characters.last();
}


function report(password) {
  alert('I found it: ' + password);
}


/* TESTS */

function test_variables() {
  if (!Object.isArray(characters)) {console.error("Array <characters> is not set!")};
}

function test_increment_chunk() {
  test_variables();
  ['a', 'Z', 'aZ', 'aaZ', 'aZZ', 'ZZZ'].each(function(c) {
    console.log(c + " => " + increment_chunk(c));
  });
}

function test_increment_character() {
  test_variables();
  characters.each(function(c) {
    console.log(c + " => " + c.increment());
  });
}

function test_highest_character() {
  test_variables();
  characters.each(function(c) {
    console.log(c + " => " + is_highest_character(c));
  });
}

