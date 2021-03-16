/* UNUSED DOCUMENT - MAY BE USEFUL FOR DYNAMIC STUFF LATER */
/* SOURCE: https://jyrkis-blogs.blogspot.com/2014/06/adding-fields-on-fly-with-ruby-on-rails.html#code4Div */

function addFilter() {

    //create Date object
    var date = new Date();

    //get number of milliseconds since midnight Jan 1, 1970 
    //and use it for address key
    var mSec = date.getTime();


   /** Translation:
       - person => visualization
       xx - address => visualization
       xx - attribute => param (?)
       - kind   street => variable_name    filter_type    value1    value2
       - addresses_attributes => filters_attributes

   */

    //Replace 0 with milliseconds
    idAttributVarname = "visualization_filters_attributes_0_variable_name".replace("0", mSec);
    nameAttributVarname = "visualization[filters_attributes][0][variable_name]".replace("0", mSec);

    idAttributFilttype = "visualization_filters_attributes_0_filter_type".replace("0", mSec);
    nameAttributFilttype = "visualization[filters_attributes][0][filter_type]".replace("0", mSec);
       
    //create <li> tag
    var li = document.createElement("li"); // **** ADD: class="form-row"

    //create label for Kind, set its for attribute, 
    //and append it to <li> element
    var labelVarname = document.createElement("label");
    labelVarname.setAttribute("for", idAttributVarname);
    var varnameLabelText = document.createTextNode("Varname");
    labelVarname.appendChild(varnameLabelText);
    li.appendChild(labelVarname);

    //create input for Kind, set its type, id and name attribute, 
    //and append it to <li> element
    var inputVarname = document.createElement("INPUT");
    inputVarname.setAttribute("type", "text");
    inputVarname.setAttribute("id", idAttributVarname);
    inputVarname.setAttribute("name", nameAttributVarname);
    li.appendChild(inputKind);

    //create label for Street, set its for attribute, 
    //and append it to <li> element
    var labelFilttype = document.createElement("label");
    labelFilttype.setAttribute("for", idAttributFilttype);
    var filttypeLabelText = document.createTextNode("Filttype");
    labelFilttype.appendChild(streetLabelFilttype);
    li.appendChild(labelFilttype);

    //create input for Street, set its type, id and name attribute, 
    //and append it to <li> element
    var inputFilttype = document.createElement("INPUT");
    inputFilttype.setAttribute("type", "text");
    inputFilttype.setAttribute("id", idAttributFilttype);
    inputFilttype.setAttribute("name", nameAttributFilttype);
    li.appendChild(inputFilttype);

    //add created <li> element with its child elements 
    //(label and input) to myList (<ul>) element
    document.getElementById("myList").appendChild(li);

    //show address header
    $("#filterHeader").show(); 
}
