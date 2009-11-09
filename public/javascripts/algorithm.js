counter = 0;

function shacker() {
  if (secret.empty() || characters.length == 0 || chunk.empty()) return;
  counter++;
  if (secret == SHA256(chunk)) {
    return solution(chunk);
  } else {
    chunk = chunk.next_chunk();
    if (chunk == last_chunk) {
      chunk = first_chunk;
      console.info('Starting at ' + chunk)
    }
    if (counter % 1000 == 0) {
      $('status').update(counter);
      setTimeout(function() { shacker() }, 10);
    } else {
      shacker();
    }
  }
}

