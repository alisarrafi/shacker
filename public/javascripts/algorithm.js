counter = 0;

function shacker() {
  if (secret.empty()) return;
  counter++;
  
  if (secret == SHA256(chunk)) {
    // Congratulations, you found it
    return solution(chunk);
    
  } else {
    // No, let's try the next password
    chunk = chunk.next_chunk();
    
    // Start from the beginning, when ran out of password space
    if (chunk == last_chunk) {
      chunk = first_chunk;
      console.info('Starting at ' + chunk)
    }
    
    // Update status message every 1000 tries
    if (counter % 1000 == 0) {
      status();
      setTimeout(function() { shacker() }, 50);
      
    // Continue
    } else {
      shacker();
    }
  }
}

function status() {
  $('status').update(": " + counter + " " + (counter / realm) + "% " + first_chunk + "-" + chunk);
}

function solution(password) {
  window.location.href = solution_url.sub('PASSWORDPLACEHOLDER', encodeURIComponent(String.interpret(password)));
}
