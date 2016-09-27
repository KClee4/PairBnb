// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require turbolinks
//= require_tree .
//= require bootstrap-sprockets
//= require bootstrap-typeahead-rails
//= require books
$(function() {
	$('#dateFrom, #dateTo').datepicker({
	      beforeShow: customRange,
	      dateFormat: "dd M yy",
	  });

    function customRange(input) {
    if (input.id == 'dateFrom') {
        var minDate = new Date();
        minDate.setDate(minDate.getDate())
        return {
            minDate: minDate
        };
    }

    if (input.id == 'dateTo') {
    	if ($('#dateFrom').val() == "") {
    		var minDate = new Date()
    		minDate.setDate(minDate.getDate() + 1) 
    	}
    	else {
        var minDate = new Date($('#dateFrom').val());
        minDate.setDate(minDate.getDate() + 1)        
      }
      return {
            minDate: minDate
        };
    }
    return {}
    }
    $( document ).ajaxComplete(function() {
    	$('#dateFrom, #dateTo').datepicker({
    	  beforeShow: customRange,
    	  dateFormat: "dd M yy",
    	});
    });
    
    $(".menu-toggle").click(function(e) {
        e.preventDefault();
        $("#wrapper").toggleClass("toggled");
    });
  
});


