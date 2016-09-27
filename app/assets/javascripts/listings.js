// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

$(function() {
	$(".search__form input[type=text").on("keyup", function() {
		$(".search__form input[type=text").autocomplete({
			
			source: $(".search__form input[type=text").data('autocomplete-source')			
		});
	});

});