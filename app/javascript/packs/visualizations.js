import $ from 'jquery';

var fil_val1 = $('#visualization_filters_attributes_0_value1').html()
$(document).ready(function() {
    $("#visualization_filters_attributes_0_variable_name").on('change', function () {
    var fil_var =  $('#visualization_filters_attributes_0_variable_name :selected').text()
    var options = $(fil_val1).filter(function() {
    		return $(this).text().includes(fil_var);
  		}).html()
});
});