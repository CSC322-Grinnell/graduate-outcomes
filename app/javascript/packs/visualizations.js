import $ from 'jquery';

$(document).ready(function() {
$("#visualization_filters_attributes_0_variable_name").on('change', function () {
    alert($(this).val());
});
});