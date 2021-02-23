# Visualizing Graduate Outcomes

A Ruby on Rails application visualizing the graduate outcome data of Grinnell students.

* Fall 1 Contributors: [Rexford Essilfie](https://github.com/RexfordEssilfie), [Tal Rastopchin](https://github.com/trastopchin), [Michael Spicer](https://github.com/Citywideiowa0), [Vijeeth Guggilla](https://github.com/vijeethguggilla), [Giang Khuat](https://github.com/giangkhuat)
* Fall 2 Contributors: [Caio Carnauba](https://github.com/ccarnauba), [Seoyeon (Stella) Lee](https://github.com/stellasylee), [Reina Shahi](https://github.com/shahirei), [Clare Simpson](https://github.com/clasky777)
* Alumni Mentor: Ian Young
* Professor: Barbara Johnson, Fernanda Eliott
* Community Partner: Sarah Barks
* Timeline: Fall 1 & 2 2020

## Description

The goal of this project is to create an efficient web application that facilitates the data analysis process so that the CLS can visualize graduate outcomes data based on demographic factors. The web application should provide the flexibility to explore various visualizations of the data based on the choice of specific dependent and independent variables. Ultimately, by using this tool, the CLS can identify any disparities in student trajectories and target key points of intervention. For example, if it is discovered that students identifying as ‘Hispanic’ are finding significantly less career-related jobs after graduation than other students, the CLS may develop certain programming in collaboration with organizations such as the Student Organization of Latinxs (SOL).

# Functionalities
- The user should be able to upload data containing student records. The web application should validate the data and inform the user of erroneous input. The uploaded data should follow the same format (same columns) as the description on the webpage.
- The user should be able to create, edit, and delete a variety of visualizations. The visualization have default value of chart title and x,y axis title.
- The user should be able to toggle variables and apply filters to selected data to create meaningful visualizations and analyses. The selection of possible value changed dynamically as the user chooses the variable.
- The user should be able to preview and manage all of the visualizations they created so far. This includes seeing what they have created so far, exporting the visualizations as images, and going back and being able to edit visualizations.

# Prerequisites

* Amazon Cloud9 setup (optional)
* Yarn
* Ruby version 2.6.3
* Rails verson 6.0.3.2
* Ubuntu Operating System (optional)

# Setting up the project on Amazon C9:

1. If you are using an Amazon Cloud9 environment, follow Hartl's tutorial to properly set one up. We highly recommend that instead of using the free Cloud9 tier, apply for a free [AWS education account](https://aws.amazon.com/education/awseducate/). Then, when creating a new environment select the largest education tier, `m5.xlarge`. Alternatively, you can set up everything on your local computer without Cloud9.

2. Make sure that you have all the required prerequisites.

3. Make sure yarn is installed

`source <(curl -sL https://cdn.learnenough.com/yarn_install)`

4. Clone the repository to your computer

`https://github.com/CSC322-Grinnell/graduate-outcomes.git                                                             `

After this, navigate to the project directory in your C9 environment (if applicable)

5. Install necessary gems

`bundle install --without production`

6. Connect to Heroku (ask prof for details) or create new deployment.
  * See Hartl tutorial "1.4.1: Heroku setup and deployment" for both
  * Also resources on Heroku website https://devcenter.heroku.com/articles/getting-started-with-ruby

# Running the project:

 Run this command in the top level directory of your project

`rails server`

# Project Components

In this section we will give a high level description of the components of this Ruby on Rails application. Following the Rails project directory convention, most of the important project files are located in the `/app`, `/db`, and `/test` directories. Our models, views, controllers, and tests are all defined and located in their respective named directories.

## Models

Our project uses a `student` model to encode individual students, and a `visualization`, `variable`, and `filter` to encode a single visualization. You can view our original UML model / class diagrams visually detailing our models in the xyz directory. You can view the current state of the database tables in the `/db/schema.rb` file.

- The `student` model attributes are hard coded based on the sample dummy input data that our community partner shared with us. The model validates the presence of every attribute, and only validates the uniqueness of the `student_id` attribute.

- The `visualization` model represents a visualization that a user creates. A `visualization` keeps track of chart specifics,  such as the type, title, and axis  titles. Each visualization is configured by keeping track of many variables and filters. Currently, we have hardcoded our `visualization` creation form to require two variables and two filters.

- The `variable` model represents a named dependent or independent variable that is used to create a visualization.

- The `filter` model represents a rule or constraint that meaningfully relates an dependent variable to an independent variable. Each filter has a filter type attribute, which describes the effect of the filter (such as `Equals`, for example) and a variable name, which represents what variable the filter influences. Each filter also has a value1 attribute and an optional value2 attribute. While a filter with filter type `Equals` only needs one input, `From..To` is a filter that can take two values, Eg. from the class year of 2019 to the class year of 2020. So, filter keeps track of a second conditional attribute value2.

It is important to note that designing a model that can represent the many different ways one can visualize data is very complicated. So, we had to make some compromises with our model design so that we could have something to start to work with. We believe that our model design works really well to create visualizations with one dependent variable, one independent variable, two filters, and a displayed count. We encourage developers to take advantage of the fact that each `visualization` has many variables and filters, instead of completely redesigning the model from scratch, when expanding the visualization configuration capabilities.

## Views

Our projects views use the `form_with` Rails method to create integrated and validated forms for our models. Other than that, don't have any specific design details to share about the contents of our views.

## Controllers

Our project has two controllers, a `VisualizationsController` and an `UploadsController`. Both controllers follow the RESTful routes and actions conventions created by including `resources :visualizations` and `resources :uploads` in the `/config/routes.rb` routing file. To get a view of which named routes correspond to which named actions, run the
```
rake routes
```
Rails command.

## Tests

Our project includes controller, integration, and model tests. We have extensive student model testing, but all testing needs to be expanded upon. Part of the reason why we are missing a lot of the `visualization`, `variable`, and `filter` tests was because we were still wrapping our heads around everything works together until the last sprint. Now that we have a basic functionality that allows users to create and view their visualizations, we need to create rigorous model tests.

- Our controller tests just make sure that we get responses when getting the appropriately named paths. These can by expanded upon.

- We have one integration test that checks to make sure that the proper HTML links appear in the navigation bar. This can be expanded on.

- Our `student` model test has the proper presence and uniqueness tests for each of the model's attributes.

- We do not have specific `visualization` or `variable` tests, and these needs to be implemented.

- Our `filter` model test only validates a valid filter. We need to create more tests for invalid filters, as well as add a conditional validation for the presence of the `value2` attribute in the model.

# To-Dos
- Accommodating more variables for files
- Live previews of the chart while form is being created/edited
- Change form depending on what chart type user selects
- Restore user selection when the user tries to edit the visualization
- Add more chart types (i.e. scatter plots, line charts)
- Have variables automatically determine what chart type is used
- Add & remove multiple filters functionality (so user can add as many filters as needed)
- More comprehensive integration test
- Comprehensive testing for visualization
- Paying attention to the color scheme of the visualization itself
- Fixing position of the delete icons in the Visualize page

# Notes & Considerations
- Currently, empty filters are being saved into the database on form creation due to a lack of robust validation.  Moving forward, we would like to add more conditional validations that check if a filter is empty before attempting to save -- this is an issue we have because if we validate the model, the form does not allow an empty filter input.
- In the form, we hard coded all graphs to display variables by count.  Eventually, users should be able to choose to display graphs by count, average, max, min, etc.
- In the form, we hard coded two filter options.  Eventually, users should be able to choose how many filters they want to apply.
- In the form, we hard coded two variables options.  Eventually, useres should be able to choose how many variables, depending on the chart type, they want to apply.

# Tools & Learning Resources
- Ruby on Rails Tutorial by Hartl 
- [Filter Graph](https://filtergraph.com/)
- [Chartkick](https://chartkick.com/)
- [Figma](https://figma.com/)
- [Upload Functionality:](https://mattboldt.com/importing-massive-data-into-rails/)
- [jQuery event calling](https://api.jquery.com/on/)
- [jQuery active record callback](https://guides.rubyonrails.org/active_record_callbacks.html)
- [Grinnell color scheme](https://www.grinnell.edu/about-grinnell/leadership-and-administration/offices-and-services/communications/our-brand-story)
- [HTML & CSS Resource](https://www.w3schools.com/)

# Additional Help & Suggestions

Pushing a branch other than master to Heroku:

`git push heroku branchname:master`

## Database Management
* Update database on Heroku:
`heroku run rails db:migrate`
* Reset database locally (removes all data including uploaded datasets):
`rails db:migrate:reset`
* Seed database:
`rails db:seed`
  * Data currently from lib/seeds/dummy_data.csv
* Reset Heroku database: `heroku pg:reset`
  * Deletes database -- destructive action, will yield warning and require confirmation
  * Will break your app until you run command to update Heroku database `heroku run rails db:migrate` (Don't worry, it's fine!)

# References

- A lot of this material is directly from the Ruby on Rails Tutorial by Hartl
