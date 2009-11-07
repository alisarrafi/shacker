function test_extensions() {
  var tmp = characters
  characters = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"];
  console.log("test_string_last();")
  test_string_last();
  console.log("test_string_is_highest();")
  test_string_is_highest();
  console.log("test_string_increment();")
  test_string_increment();
  console.log("test_string_increment_last();")
  test_string_increment_last();
  console.log("test_string_next_chunk();")
  test_string_next_chunk();
  evaluate_test_results();
  characters = tmp
}

// Returns last character of a string
String.prototype.last = function() {
  return this.charAt(this.length-1)
};
function test_string_last() {
  assert_equal("a", "a".last());
  assert_equal("B", "aB".last());
  assert_equal("f", "ASDf".last());
  assert_equal("", "".last());
}

// Indicates, whether a character is the highest
String.prototype.is_highest = function() {
  return this == characters.last();
};
function test_string_is_highest() {
  assert_equal("a", characters.first());
  assert_equal("Z", characters.last());
  assert_equal(false, "a".is_highest());
  assert_equal(true, "Z".is_highest());
  assert_equal(false, "".is_highest());
}

// Increments a character by one (returns lowest character if not found)
String.prototype.increment = function() {
  if (this.is_highest()) return characters.first();  // If already highest character, return lowest character
  return characters[characters.indexOf(String(this)) + 1];   // Else, increment character by one
}
function test_string_increment() {
  assert_equal("b", "a".increment());
  assert_equal("A", "z".increment());
  assert_equal("a", "Z".increment());
  assert_equal("a", "!".increment());
  assert_equal("a", "abc".increment());
  assert_equal("a", "".increment());
}

// Increments only the last character of a string
String.prototype.increment_last = function() {
  if (this.length == 0) return "";
  if (this.length == 1) return this.increment();
  return this.slice(0, this.length - 1) + this.last().increment();
};
function test_string_increment_last() {
  assert_equal("b", "a".increment_last());
  assert_equal("aC", "aB".increment_last());
  assert_equal("ASDg", "ASDf".increment_last());
  assert_equal("asdasdasdasdasda", "asdasdasdasdasdZ".increment_last());
  assert_equal("", "".increment_last());
}

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
function test_string_next_chunk() {
  assert_equal("a", "".next_chunk());
  assert_equal("aa", "Z".next_chunk());
  assert_equal("y", "x".next_chunk());
  assert_equal("abce", "abcd".next_chunk());
  assert_equal("abcy", "abcx".next_chunk());
  assert_equal("abda", "abcZ".next_chunk());
  assert_equal("aaaabaaab", "aaaabaaaa".next_chunk());
  assert_equal("aaaabaaaa", "aaaaaZZZZ".next_chunk());
  assert_equal("aaaa", "ZZZ".next_chunk());
}
