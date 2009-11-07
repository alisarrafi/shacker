var test_results = []

function assert_equal(expected, actual) {
  passed = expected == actual;
  if (!passed) {
    console.error("Expected <" + expected + "> but was <" + actual + ">");
  }
  test_results.push(!passed);
}

function evaluate_test_results() {
  if (test_results.any()) {
    //console.error("At least one test failed.");
  } else {
    console.info("All tests passed.");
  }
}
