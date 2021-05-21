# Visualizing Graduate Outcomes

A Ruby on Rails application visualizing the graduate outcome data of Grinnell students.

* Fall 1 Contributors: [Rexford Essilfie](https://github.com/RexfordEssilfie), [Tal Rastopchin](https://github.com/trastopchin), [Michael Spicer](https://github.com/Citywideiowa0), [Vijeeth Guggilla](https://github.com/vijeethguggilla), [Giang Khuat](https://github.com/giangkhuat)
* Fall 2 Contributors: [Caio Carnauba](https://github.com/ccarnauba), [Seoyeon (Stella) Lee](https://github.com/stellasylee), [Reina Shahi](https://github.com/shahirei), [Clare Simpson](https://github.com/clasky777)
* Spring 1 Contributors: [Ally R](https://github.com/Ally-R), [Vidush Goswami](https://github.com/vidushg), [Erin Scherl](https://github.com/thehelpfulfrog), [Gabby Masini](https://github.com/masiniga), [Xuanhe Chen](https://github.com/Rhopala)
* Spring 2 Contributors: Stefan Ilic, [Cameron Leung](https://github.com/leungcam), [Ben Phung](https://github.com/bphung45), Jax Seiler
* Alumni Mentor: Ian Young
* Professor: Barbara Johnson, Fernanda Eliott
* Community Partner: Sarah Barks, on behalf of the Grinell College Center for Careers, Life, and Service (CLS)
* Timeline: 2020-2021 academic year

# Description

The goal of this project is to create an intuitive web application that allows CLS advisers to visualize graduate outcomes data based on demographic factors, while assuming little to no technical or statistical knowledge. 
The web application allows authorized users to create column and bar charts that show the percentage of students who fall into particular identity groups (e.g. identify with a particular ethnic group) that experienced a particular outcome (e.g. had a research experience while at Grinnell). 

Ultimately, we hope that this tool can help the CLS identify systemic inequalities in different students' experiences and outcomes at Grinnell. 
For example, if CLS advisers were to find that students identifying as ‘Hispanic’ are finding disproportionately fewer jobs related to their career ambitions than other students, the CLS may develop specific resources to address this inequality.

# Functionalities
- The user should be able to upload data containing student records. The web application should validate the data and inform the user of erroneous input. The uploaded data should follow the same format (same columns) as the description on the webpage.

- The user should be able to create, show, list, update, and delete a bar and column charts, which show how a 'Group Variable' interacts with an 'Outcome Variable'. Users should also be able to export saved visualizations as images.

- The user should be able to create an account, log in, and add to a database of emails that are approved to create new accounts.

# Prerequisites

* Yarn
* Ruby version 2.6.3
* Rails verson 6.0.3.2
* Heroku

Some recommend using the Amazon Cloud9 development environment, which some contributors have used successfully in the past.
Also, we recommend following Michael Hartl's Ruby on Rails [tutorial](https://www.learnenough.com/ruby-on-rails-6th-edition-tutorial) to learn how to use Ruby on Rails. We use many of his instructions and commands when explaining how to set up the project.

# Setting up the project:

1. Set up an Amazon Cloud9 environment (if you want, it's optional).
If you are a college student (you most likely are), we highly recommend applying for a free [AWS education account](https://aws.amazon.com/education/awseducate/) instead of using the free Cloud9 tier. 
Then, when creating a new environment select the largest education tier, `m5.xlarge`. 

Alternatively, you can set up everything on your local computer without Cloud9.

2. Make sure that you have all the required prerequisites.

If you need to install Rails (and space is tight--e.g. you are using AWS Cloud9), run

`echo "gem: --no-document" >> ~/.gemrc`

to configure your the gem installer to skip downloading the Rails documentation.
Then, run

`gem install rails -v 6.0.3.2`

to actually install Rails.

If you need to install yarn, run the following command:
`source <(curl -sL https://cdn.learnenough.com/yarn_install)`

3. Clone this repository to your computer with

`git clone https://github.com/CSC322-Grinnell/graduate-outcomes.git` 

Don't forget to move to the project directory. 

You may need to configure your development environment to know your git user name and email with 
`git config --global user.name $YOUR_GITHUB_USERNAME`

and

`git config --global user.email $YOUR_GITHUB_EMAIL`.

4. Install the necessary gems.

First, configure your environment to skip installing the production gems:

`bundle config set --local without 'production'`.

Then, run `bundle install` to actually install the gems.

5. Ask the Heroku Account Owner to add your Heroku account as a collaborator (if you are planning on deploying the project). 

First, if you don't have Heroku already, you can install it with 

`source <(curl -sL https://cdn.learnenough.com/heroku_install)`.

Then, log in to your heroku account with 

`heroku login --interactive`.

Set up a git remote to the existing grad-outcomes Heroku app with 

`heroku git:remote -a grad-outcomes`.

You are now set up to deploy when ready.

# Running the project:

 Run this command in the top level directory of your project

`rails server`

# Running SimpleCov

SimpleCov will run when `rails test` is called. To view a detailed breakdown of test coverage, run `open coverage/index.html`. If the code coverage seems unexpectedly low, try running `Spring stop` before `rails test`.

# Project Components

In this section, we will give a high level description of the components of this Ruby on Rails application. Following the Rails project directory convention, most of the important project files are located in the `/app`, `/db`, and `/test` directories. Our models, views, controllers, and tests are all defined and located in their respective named directories.

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


## Notes & Considerations
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
