// Have a little spinner in the corner while loading Ajax requests
Ajax.Responders.register({
  onCreate: function(){
    $('busy').show();  
  }, 
  onComplete: function(){
    $('busy').hide();  
  },
  onFailure: function(transport) {
    alert('Ooops.');
    $('busy').hide();  
  }
});

// Toggle the solved status
ToggleSolved = Behavior.create({
  onclick : function(e) {
    Event.stop(e);
    new Ajax.Request('/toggle', {asynchronous:true, evalScripts:true})   
  }
});

// Reset settings to default
ResetSettings = Behavior.create({
  onclick : function(e) {
    Event.stop(e);
    if (confirm("Are you sure you want to load the default settings?")) window.location.href = "/reset";
  }
});

// Register behaviors
Event.addBehavior({ 
  '#toggle_solved' : ToggleSolved,
  '#reset_settings' : ResetSettings
});
