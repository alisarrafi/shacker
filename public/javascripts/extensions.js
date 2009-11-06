function test_extensions() {
  test_string_last();
  evaluate_test_results();
}

// Returns last character of a string
String.prototype.last = function() {
  return this.slice(this.length - 1, this.length)
};

function test_string_last() {
  assert_equal("a", "a".last());
  assert_equal("Bs", "aB".last());
  assert_equal("f", "ASDf".last());
  assert_equal("", "".last());
}



String.prototype.increment = function() {
  return this == characters.last();
};

String.prototype.increment_last = function() {
  return this.slice(this.length - 2, this.length) + this.last().increment();
};
