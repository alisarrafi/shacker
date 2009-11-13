var test_results = []
var characters = []
var testmode = false

function test() {
  testmode = true;
  console.info("Running JavaScript Tests of /javascripts/test_helper.js")
  setup();
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
}

function setup() {
  characters = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z",
                "A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z",
                "0","1","2","3","4","5","6","7","8","9","!","\"","#","$","%","&","'","(",")","*","+",",","-",".","/","="];
}

/****** TESTS ******/

function test_string_next_chunk() {
  assert_equal("a", "".next_chunk());
  assert_equal("aa", "=".next_chunk());
  assert_equal("y", "x".next_chunk());
  assert_equal("abce", "abcd".next_chunk());
  assert_equal("abcy", "abcx".next_chunk());
  assert_equal("abc0", "abcZ".next_chunk());
  assert_equal("aa*", "aa)".next_chunk());
  assert_equal("aa+", "aa*".next_chunk());
  assert_equal("aa,", "aa+".next_chunk());
  assert_equal("aaaabaaab", "aaaabaaaa".next_chunk());
  assert_equal("aaaabaaaa", "aaaaa====".next_chunk());
  assert_equal("aaaa", "===".next_chunk());
}

function test_string_last() {
  assert_equal("a", "a".last());
  assert_equal("B", "aB".last());
  assert_equal("f", "ASDf".last());
  assert_equal("", "".last());
}

function test_string_is_highest() {
  assert_equal("a", characters.first());
  assert_equal("=", characters.last());
  assert_equal(false, "a".is_highest());
  assert_equal(true, "=".is_highest());
  assert_equal(false, "".is_highest());
}

function test_string_increment() {
  assert_equal("b", "a".increment());
  assert_equal("A", "z".increment());
  assert_equal("0", "Z".increment());
  assert_equal("\"", "!".increment());
  assert_equal("=", "/".increment());
  assert_equal("a", "=".increment());
  assert_equal("a", "abc".increment());
  assert_equal("a", "".increment());
}

function test_string_increment_last() {
  assert_equal("b", "a".increment_last());
  assert_equal("aC", "aB".increment_last());
  assert_equal("ASDg", "ASDf".increment_last());
  assert_equal("asdasdasdasdasd0", "asdasdasdasdasdZ".increment_last());
  assert_equal("asdasdasdasdasd.", "asdasdasdasdasd-".increment_last());
  assert_equal("", "".increment_last());
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