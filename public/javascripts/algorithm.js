var step = -1
var secret
var chunk
var characters = []
var counter = 0

function setup() {
  if (!secret.empty() && characters.length > 0 && !chunk.empty()) {
    $('setup').insert('Secret: ' + secret + '<br/>');
    $('setup').insert('Initial password: "' + chunk + '"<br/>');
    setTimeout(function() { shacker() }, 10);
  }
}

function shacker() {
  if (secret.empty() || characters.length == 0 || chunk.empty()) return;
  counter++;
  if (secret == SHA256(chunk)) {
    return report(chunk);
  } else {
    chunk = chunk.next_chunk();
    if (counter % 1000 == 0) {
      $('status').update(counter);
      setTimeout(function() { shacker() }, 10);
    } else {
      shacker();
    }
  }
}

function report(password) {
  alert('I found it: ' + password);
}

function centerflash(id) {
  if (screen && screen.availWidth && $(id) && $('container')) {
    containerleft = $('container').makePositioned().cumulativeOffset($(id)).first();
    containerwidth = $('container').getDimensions()['width'];
    $(id).setStyle({left: (containerleft + (containerwidth - $(id).getDimensions()['width']) / 2) + "px"});
  }
}


