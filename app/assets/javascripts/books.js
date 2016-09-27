var ready;
ready = function() {
  var engine = new Bloodhound({
    datumTokenizer: function (d) {
      return Bloodhound.tokenizers.whitespace(d.value);
    },
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    remote: { 
        url: "/listings/autocomplete?query=%QUERY",
        wildcard: "%QUERY"
    }
});
 
  var promise = engine.initialize();
 
  promise
  .done(function() { console.log('success!'); })
  .fail(function() { console.log('err!'); });
 
  $('.typeahead').typeahead(null, {

    displayKey: 'title',
    source: engine.ttAdapter()
  });
}
 
$(document).ready(ready);
$(document).on('page:load', ready);