// Keeping track of how many passwords we tried.
// We want to send this to the server in our report intervals
counter = 0;

// You may want to override this if you are creating a widget.
function start_shacker() {
  console.log("Starting algorithm.");
  shacker();
}

// This is the main brute force algorithm
function shacker() {
  if (secret.empty()) return;
  counter++;
  
  if (secret == SHA256(chunk)) {
    // Congratulations, you found it
    return solution(chunk);
    
  } else {
    
    
    // Nothing found yet, let's try the next password
    if (chunk == last_chunk || chunk.length > length) {
      // Start from the beginning, when ran out of password space
      chunk = first_chunk;
      console.log('Starting at ' + chunk)
    } else {
      // Increment the chunk by one if we're somewhere in the middle
      chunk = chunk.next_chunk();    
    }
    
    // Hand in a report
    if (report_interval > 0 && counter % report_interval == 0) {
      report(counter)
    }
    
    // Update status message every status_interval tries
    if (counter % status_interval == 0) {
      status();
      setTimeout(function() { shacker() }, status_delay);
      
    // Continue
    } else {
      //console.log(chunk);
      if (loop_delay > 0) {
        setTimeout(function() { shacker() }, loop_delay);        
      } else {
        shacker();
      }
    }
  }
}

// Updating the <div id="status"></div>
function status() {
  if (!$('status')) return;
  $('status').update(": " + counter + " " + (counter / realm) + "% " + first_chunk + "-" + chunk);
}

// Send interval report
function report(counter_to_report) {
  console.log('Reporting "' + counter_to_report + '"');
  new Ajax.Request(report_url.sub('COUNTERPLACEHOLDER', counter_to_report), {asynchronous:true});
}

// Redirect to solution page
function solution(password) {
  console.log('Handing in solution "' + password + '"');
  window.location.href = solution_url.sub('PASSWORDPLACEHOLDER', encodeURIComponent(String.interpret(password)));
}
