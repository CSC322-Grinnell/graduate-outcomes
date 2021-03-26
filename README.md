# Visualizing Graduate Outcomes

A Ruby on Rails application visualizing the graduate outcome data of Grinnell students.

* Fall 1 Contributors: [Rexford Essilfie](https://github.com/RexfordEssilfie), [Tal Rastopchin](https://github.com/trastopchin), [Michael Spicer](https://github.com/Citywideiowa0), [Vijeeth Guggilla](https://github.com/vijeethguggilla), [Giang Khuat](https://github.com/giangkhuat)
* Fall 2 Contributors: [Caio Carnauba](https://github.com/ccarnauba), [Seoyeon (Stella) Lee](https://github.com/stellasylee), [Reina Shahi](https://github.com/shahirei), [Clare Simpson](https://github.com/clasky777)
* Spring 1 Contributors: [Ally R](https://github.com/Ally-R), [Vidush Goswami](https://github.com/vidushg), [Erin Scherl](https://github.com/thehelpfulfrog), [Gabby Masini](https://github.com/masiniga), [Xuanhe Chen](https://github.com/Rhopala)
* Alumni Mentor: Ian Young
* Professor: Barbara Johnson, Fernanda Eliott
* Community Partner: Sarah Barks
* Timeline: Fall 1 & 2 2020, Spring 1 2021

## NOTE: Site Prototype Link (Forgot to include in report!)
We forgot to include this in our report, but the first group (Fall 1) created a wireframe/prototype of the website on Figma, a UI design website. You can access this wireframe here: https://www.figma.com/file/puXUzvp9MJaMspDpzQxNQK/Graduate-Outcomes. The design they came up with is quite different from the direction future groups took the site, including us, and we are not suggesting that you should significantly change the site to fit the wireframe. The wireframe was an initial idea of how the site may look; we think that the current design of the site works well and our community partner seems satisfied with it as well, even though it is not the same as the wireframe. However, the wireframe also contains some ideas that may be helpful for implementing the to-do items, such as the ability to preview visualizations while editing the form, among other things. Note also that we aren't sure whether the wireframe uses official Grinnell colors, but the site should. See `app/assets/stylesheets/grin_colors.scss` for all [official Grinnell colors](https://www.grinnell.edu/about-grinnell/leadership-and-administration/offices-and-services/communications/our-brand-story) that you may use for the site.

# Description

The goal of this project is to create an efficient web application that facilitates the data analysis process so that the CLS can visualize graduate outcomes data based on demographic factors. The web application should provide the flexibility to explore various visualizations of the data based on the choice of specific dependent and independent variables. Ultimately, by using this tool, the CLS can identify any disparities in student trajectories and target key points of intervention. For example, if it is discovered that students identifying as ‘Hispanic’ are finding significantly less career-related jobs after graduation than other students, the CLS may develop certain programming in collaboration with organizations such as the Student Organization of Latinxs (SOL).

# Functionalities
- The user should be able to upload data containing student records. The web application should validate the data and inform the user of erroneous input. The uploaded data should follow the same format (same columns) as the description on the webpage.
- The user should be able to create, edit, and delete a variety of visualizations. The visualization have default value of chart title and x,y axis title.
- The user should be able to toggle variables and apply filters to selected data to create meaningful visualizations and analyses. The selection of possible value changed dynamically as the user chooses the variable.
- The user should be able to preview and manage all of the visualizations they created so far. This includes seeing what they have created so far, exporting the visualizations as images, and going back and being able to edit visualizations.
- The user should be able to create an account, log in, and add to a database of emails that are approved to create new accounts.

# Prerequisites

* Amazon Cloud9 setup (optional)
* Yarn
* Ruby version 2.6.3
* Rails verson 6.0.3.2
* Ubuntu Operating System (optional)

# Setting up the project:

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

# Running SimpleCov

SimpleCov will run when `rails test` is called. To view a detailed breakdown of test coverage, run `open coverage/index.html`. If the code coverage seems to low, try running `Spring stop` before `rails test`.

# Project Components

In this section we will give a high level description of the components of this Ruby on Rails application. Following the Rails project directory convention, most of the important project files are located in the `/app`, `/db`, and `/test` directories. Our models, views, controllers, and tests are all defined and located in their respective named directories.

## Models

Our project uses a `student` model to encode individual students, and a `visualization`, `variable`, and `filter` to encode a single visualization. There is also a `user` model to encode the profiles of different users of the site, as well as a `valid_email` model to encode the list of emails that are approved to make accounts. You can view our original UML model / class diagrams visually detailing our models in the xyz directory. You can view the current state of the database tables in the `/db/schema.rb` file.

- The `student` model attributes are hard coded based on the sample dummy input data that our community partner shared with us. The model validates the presence of every attribute, and only validates the uniqueness of the `student_id` attribute.

- The `visualization` model represents a visualization that a user creates. A `visualization` keeps track of chart specifics,  such as the type, title, and axis  titles. Each visualization is configured by keeping track of many variables and filters. Currently, we have hardcoded our `visualization` creation form to require two variables and two filters.

- The `variable` model represents a named dependent or independent variable that is used to create a visualization.

- The `filter` model represents a rule or constraint that meaningfully relates an dependent variable to an independent variable. Each filter has a filter type attribute, which describes the effect of the filter (such as `Equals`, for example) and a variable name, which represents what variable the filter influences. Each filter also has a value1 attribute and an optional value2 attribute. While a filter with filter type `Equals` only needs one input, `From..To` is a filter that can take two values, Eg. from the class year of 2019 to the class year of 2020. So, filter keeps track of a second conditional attribute value2.

- The `user` model includes an email and password digest associated with a user. A user can be created by signing up, but the email used to sign up must already exist in the valid_email database.

- The `valid_email` model consists of an email. In order for a user to be created, a valid_email must exist that corresponds to the email that the user inputs. valid_emails can be added to the database by a logged in user.

It is important to note that designing a model that can represent the many different ways one can visualize data is very complicated. So, we had to make some compromises with our model design so that we could have something to start to work with. We believe that our model design works really well to create visualizations with one dependent variable, one independent variable, two filters, and a displayed count. We encourage developers to take advantage of the fact that each `visualization` has many variables and filters, instead of completely redesigning the model from scratch, when expanding the visualization configuration capabilities.

## Views

Our projects views use the `form_with` Rails method to create integrated and validated forms for our models. Other than that, don't have any specific design details to share about the contents of our views.

## Controllers

Our project has a `VisualizationsController`, an `UploadsController`, a `SessionsController`, a `UsersController`, and a `ValidEmailsController`. The controllers follow the RESTful routes and actions conventions created by including `resources :visualizations`, `resources :uploads`, `resources :users`, and `resources :valid_emails` in the `/config/routes.rb` routing file. The `VisualizationsController` contains the code that controlls dynamic addition and deletion of variables and filters for the visualization form, and these methods need to be updated to be less dangerous. More information about this is in the team report. To get a view of which named routes correspond to which named actions, run the
```
rake routes
```
Rails command.

## Tests

Our project includes controller, integration, and model tests. We have extensive student model testing, but all testing needs to be expanded upon. 

- Our controller tests just make sure that we get responses when getting the appropriately named paths. These can by expanded upon.

- Our `student` model test has the proper presence and uniqueness tests for each of the model's attributes.

- Our `filter` model test only validates a valid filter. We need to create more tests for invalid filters, as well as add a conditional validation for the presence of the `value2` attribute in the model.

- Our `user` model validates the presence of a secure password and the existence of an email in the `valid_emails` database.

- Our `valid_emails` model vaidates the presence and correct formatting of the email.

# To-Dos
- Display previews of visualization while form is being edited
- Have variables automatically determine what chart type to use
- Comprehensive testing for visualization
- Create homepage and make it the new landing page for the site (along with login)
   * Note: Please use official Grinnell colors for the site, found in `app/assets/stylesheets/grin_colors.scss` and on the [Grinnell website](https://www.grinnell.edu/about-grinnell/leadership-and-administration/offices-and-services/communications/our-brand-story).
- Making the number of variables more flexible when uploading CSV files
   * Ability to upload entries that have certain blank fields (e.g. gs_level blank if gs_select is 'no')
- Create a “User Guide” page that instructs people in the CLS, who may have little to no prior experience, on how to build visualizations that may be useful to them
   * __*Note: see [`user-guide-info.md`](./user-guide-info.md) in this repo for info about visualizations that may be helpful for creating the user guide and understanding how to use the site yourself.*__
- Better visualization handling of more than two variables
- Restrict number of variables to 1 for pie charts - currently creates empty graph with label "undefined". Other similar changes to help users create meaningful forms.
- Implement functionality behind independent and dependent selections for variables. Currently these selections do nothing (default back to group by).
- Fix implementation of adding and deleting variables and filters to be more safe (see `app/controllers/visualizations_controller.rb`)


# Notes & Considerations
- In the form, we hard coded all graphs to display variables by count.  Eventually, users should be able to choose to display graphs by count, average, max, min, etc.
- Eventually, the number of variables the user chooses should be restricted by the chart type they chose.
- The site should use official Grinnell colors, found in `app/assets/stylesheets/grin_colors.scss` and on the [Grinnell website](https://www.grinnell.edu/about-grinnell/leadership-and-administration/offices-and-services/communications/our-brand-story).

# Tools & Learning Resources
- Ruby on Rails Tutorial by Hartl 
- [Filter Graph](https://filtergraph.com/)
- [Chartkick](https://chartkick.com/)
- [SimpleCov](https://github.com/simplecov-ruby/simplecov)
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
* Reset database locally (removes all data including uploaded datasets, visualizations, and accounts):
`rails db:migrate:reset`
* Seed database:
`rails db:seed`
  * Data currently from lib/seeds/dummy_data3.csv
* Reset Heroku database: `heroku pg:reset`
  * __NOTE: The project is at a stage where this is a bad idea unless absolutely necessary.__ This will re-set all created visualizations, will remove access to all users except Sarah, and will reset Sarah's password to the default, which is not secure (it is visible on GitHub). If you must do this, please talk with our community partner first as it will delete their work if they are using the site.
  * Deletes database -- destructive action, will yield warning and require confirmation
  * Will break your app until you run command to update Heroku database `heroku run rails db:migrate`

# References

- A lot of this material is directly from the Ruby on Rails Tutorial by Hartl
