# Info for User Guide & How Visualizations Work

## About this document
This document is a rough, incomplete information dump about how visualizations and uploading datasets currently works for the site, what different graphs and form selections do, and options users have for editing and downloading visualizations. We brainstormed this information throughout the course of the term as we learned more about the site from experimenting. We want to emphasize that this document is not comprehensive, and is not meant to be taken as the totality of material for a user guide. We hope instead that it will provide a good starting point, and help the next group get to know the visualization process and options so that they can create a useful user guide and better inform our community partner how to create the visualizations that they want.

We suggest that the next team experiment themselves in creating different visualizations and uploading new datasets. We also strongly encourage the next group to perform Usability Testing (show the site to new users who are unfamiliar with it) to gain information about what is clear, what is confusing, and what information and format would be useful for the user guide. We did not do any of this work during our time with the project, and the suggestions below therefore do not necessarily reflect the most important details for new users trying to understand how to use the site.

## About visualizations
### Chart types
* Bar: graphs bars horizontally, out of y-axis
* Column: graphs bars vertically, out of x-axis
* Pie: graphs a pie chart (one variable only)
* Line: a line graph. Note that this chart type doesn’t make sense for any of the current selections except with class year as the primary variable (to see change in some chosen secondary variable over time/ over the years).

### Variables
* There is currently no difference between “group-by”, “independent”, and “dependent” selections — see app/helpers/visualizations_helper.rb
  * In the future, this functionality should be built out
  * It is possible that these are not useful categories for the types of data the CLS is working with. If so, consider changing role selections to “primary” and “secondary”, in which group-by is always used and the grouping is dictated by the role selection and not the order (see more about how order matters below)
* The order in which you select variables matters for “group-by”
  * First variable => primary grouping. Represented by y-axis for bar graphs, and x-axis for column graphs and line graphs.
  * Second variable => secondary grouping. Represented by colors, whose values are in the figure key.
* The other axis (x-axis for bar graphs, y-axis for column and line graphs) always represents the count, or number of students.
* Selecting more than one variable for a pie chart will result in an undefined chart. In the future, this should be changed to throw an error and stay on the form page until the user removes all but one variable.’
* Selecting more than two variables for any chart will convert all variables into primary variables, and produce a relatively useless chart that has poor grouping. In the future, this should be changed so that items group nicely even with 3 variables selected.

### Filters
* Filters simply pre-screen the data that will be used in the visualization.
* Filtering out “N/A” or other unwanted fields: One use for filters to mention in the user guide is how to filter out “N/A” fields or other unwanted values. To do this, simply select the “Not Equal To” filter and whatever the unwanted value is.
* There is no limit to the number of filters you can use for any visualization. It is possible to filter out all values and create a blank visualization.
* The “Value2” selection for filters is ignored for all filter selections except “From..To”
* In the future, “From..To” should either require a value2 selection (throw an error message) or default to “Equals” when only one selection is provided. Currently, selecting only value1 will create an empty graph. There are also some other weird behaviors with certain filter selections (for example selecting major1 greater than ENG, which doesn’t make sense) that could be restricted or throw error messages.

### Other visualization options
* Download button: Users can download a visualization with the light gray button that appears when hovering over a completed visualization (top right of the graph area of the visualization)

![Download Button Image](download-button-img.png?raw=true)

## About uploading data
* In order to upload a .csv file, its categories (column headers) must exactly match those listed on the uploads page of the website
* If any cell in a row is empty, that entire row/entry is currently rejected
* Users should know that they can convert Excel spreadsheets into .csv files by choosing .csv as the file type when saving their Excel file. They can then upload the .csv file to the site.
* We have not explored much about what happens when you download multiple datasets. This would be a good area for the next group to look into and record in the user guide.

## Idea for user guide page
* Have a visual walk-through of creating some meaningful figure (e.g. relationship of gender identity to graduate school enrollment) and then editing it.
* Do Usability Testing to inform how to format the user guide page, and what information to include
