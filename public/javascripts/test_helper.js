var test_results = []

function assert_equal(expected, actual) {
  test_results.push (expected != actual);
}

function evaluate_test_results() {
  if (test_results.any()) 
    console.error("At least one test failed.");
  else
    console.info("All tests passed.");
}