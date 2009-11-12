var test_results = []
var characters = null

function test() {
  var tmp = characters
  console.info("Running JavaScript Tests of /javascripts/test_helper.js")
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

/****** TESTS ******/

function test_string_last() {
  assert_equal("a", "a".last());
  assert_equal("B", "aB".last());
  assert_equal("f", "ASDf".last());
  assert_equal("", "".last());
}

function test_string_is_highest() {
  assert_equal("a", characters.first());
  assert_equal("Z", characters.last());
  assert_equal(false, "a".is_highest());
  assert_equal(true, "Z".is_highest());
  assert_equal(false, "".is_highest());
}

function test_string_increment() {
  assert_equal("b", "a".increment());
  assert_equal("A", "z".increment());
  assert_equal("a", "Z".increment());
  assert_equal("a", "!".increment());
  assert_equal("a", "abc".increment());
  assert_equal("a", "".increment());
}

function test_string_increment_last() {
  assert_equal("b", "a".increment_last());
  assert_equal("aC", "aB".increment_last());
  assert_equal("ASDg", "ASDf".increment_last());
  assert_equal("asdasdasdasdasda", "asdasdasdasdasdZ".increment_last());
  assert_equal("", "".increment_last());
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

/****** HELPER ******/

function evaluate_test_results() {
  if (test_results.any()) {
    //console.error("At least one test failed.");
  } else {
    console.info("All tests passed.");
  }
}

function assert_equal(expected, actual) {
  passed = expected == actual;
  if (!passed) {
    console.error("Expected <" + expected + "> but was <" + actual + ">");
  }
  test_results.push(!passed);
}