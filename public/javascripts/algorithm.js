// Keeping track of how many passwords we tried.
// We want to send this to the server in our report intervals
counter = 0;

// You may want to override this if you are creating a widget.
function start_shacker() {
  shacker();
}

// This is the main brute force algorithm
function shacker() {
  if (secret.empty()) return;
  counter++;
  
  if (secret == SHA256(chunk)) {
    // Congratulations, you found it
    solution(chunk);
  } else {
    
    // Nothing found yet, let's try the next password
    if (chunk == last_chunk || chunk.length > length) {
      // Start from the beginning, when ran out of password space
      chunk = first_chunk;
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
  if ($('status')) $('status').update(": " + counter + " " + ((counter / realm) * 100).toPrecision(8) + "% " + init_chunk + "-" + chunk);
}

// Send interval report
function report(counter_to_report) {
  new Ajax.Request(report_url.sub('COUNTERPLACEHOLDER', counter_to_report), {asynchronous:true, evalScripts:true});
}

// Redirect to solution page
function solution(password) {
  url = solution_url.sub('PASSWORDPLACEHOLDER', encodeURIComponent(String.interpret(password)));
  new Ajax.Request(url, {asynchronous:true});
  $('status_label').update("");
  $('status').update("");
  // This rest of this function is a hack, in case the browser is really, really stupid.
  $('setup').update("<h2>Congratulations!</h2>You found the password! It's <div id='solution'>" + password + "</div><a href='" + url + "'><h2>Please hand in the solution via THIS link.</h2></a>");
  window.location.href = url;
  window.location.href = url;
  window.location.href = url;
}
