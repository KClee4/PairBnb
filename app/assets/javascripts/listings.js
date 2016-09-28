// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

$(function() {
	$( "#slider-range" ).slider({
	  range: true,
	  min: 100,
	  max: 2000,
	  values: [ 75, 300 ],
	  slide: function( event, ui ) {
	    $( "#amount" ).val( "RM" + ui.values[ 0 ] + " - RM" + ui.values[ 1 ] );
	  },
	  change: function(event, ui) {
		 $("#min").attr('value', $("#slider-range").slider("values", 0));
		 $("#max").attr('value', $("#slider-range").slider("values", 1));
		 $(this).parent().submit();
		}
	});
	$( "#amount" ).val( "RM" + $( "#slider-range" ).slider( "values", 0 ) +
	  " - RM" + $( "#slider-range" ).slider( "values", 1 ) );
});