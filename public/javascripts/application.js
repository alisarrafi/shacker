// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

var chunks = []

function shack() {
  chunks.each(function(chunk) {
    string = "<" + chunk + ">  " + SHA256(chunk) + "<br/>";
    /*
    console.log(string);
    $('result').insert(string); 
    $('chunks').update(chunk);
    */
    
    
  });
}