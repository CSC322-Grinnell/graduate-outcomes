// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("jquery")

// Additional packages
require("chartkick")
require("chart.js")
//= require visualization


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

import $ from 'jquery';

$(document).on('turbolinks:load', function() {
    
    
    $(".filter_var").on('change', function (event) {
        // Selected variable
        var fil_var =  $("#" + event.target.id + " :selected").text();
        
        var dropdown_id = event.target.id.substring(0, 35); // visualization_filters_attributes_(number)_
        
        var values = $("#" + dropdown_id+ "value1 option"); 
        var values2 = $("#" + dropdown_id+ "value2 option"); 
        
        // Restore the css setting as default
        values.prop('disabled', false).css('display', 'block');
        values2.prop('disabled', false).css('display', 'block');
        
        
        // Filter the values
        values.filter(function() {
            return !$(this).text().startsWith(fil_var); 
        }).prop('disabled', true).css('display', 'none');
        
        values2.filter(function() {
            return !$(this).text().startsWith(fil_var); 
        }).prop('disabled', true).css('display', 'none');
        
    });
    
    
});
