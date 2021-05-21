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

Our project uses a `student` model to encode individual students, and a `visualization` (containing many `variable` model attributes) to encode a single visualization. There is also a `user` model to encode the profiles of different users of the site, as well as a `valid_email` model to encode the list of emails that are approved to make accounts. You can view our original UML model / class diagrams visually detailing our models in the xyz directory. You can view the current state of the database tables in the `/db/schema.rb` file.

- The `student` model attributes are hard coded based on the sample dummy input data that our community partner shared with us. The model validates the presence of every attribute, and only validates the uniqueness of the `student_id` attribute.

- The `visualization` model represents a visualization that a user creates. A `visualization` keeps track of the chart attributes, such as the type, title, and axes titles. Each visualization is configured by keeping track of two variables. Each visualization should have exactly one variable that acts in the role of a 'Group Variable' and exactly one with the role 'Outcome Variable'. 

A 'Group Variable' denotes an identity group that students may belong to, such as gender or class year. An 'Outcome Variable' denotes a particular outcome that students may or may not have achieved/experienced, for example going to graduate school or entering a particular job field.

- The `variable` model represents a quantity that was measured of students (columns in the students table). Each variable should have a `name` that appears as a column label in the students table and `role` that is either "group" or "outcome".

- The `filter` model is no longer supported by the code (it doesn't make sense to say one major "is less than" another major). It should be deleted and likely replaced with an "arbitrary subset-ing method", see To-Dos.

- The `user` model includes an email and password digest associated with a user. A user can be created by signing up, but the email used to sign up must already exist in the `valid_email` database.

- The `valid_email` model consists of an email. In order for a user to be created, a `valid_email` must exist that corresponds to the email that the user inputs. `valid_emails` can be added to the database by a logged in user.

## Views

Our projects views use the `form_with` Rails method to create integrated and validated forms for our models. See https://guides.rubyonrails.org/form_helpers.html for more information.

## Controllers

Our project has a `VisualizationsController`, an `UploadsController`, a `SessionsController`, a `UsersController`, and a `ValidEmailsController`. The controllers follow the RESTful routes and actions conventions created by including `resources :visualizations`, `resources :uploads`, `resources :users`, and `resources :valid_emails` in the `/config/routes.rb` routing file.

To get a view of which named routes correspond to which named actions, run the
```
rake routes
```
Rails command.

## Tests

Our project includes controller, integration, and model tests.

- Our `visualizations_controller` tests test that the actions meet the requirements for a RESTful (also, Rails) resource.

- Our `visualizations_helper` tests test the methods used to help build a chart from a `visualization` object.

- Our `student` model test has the proper presence and uniqueness tests for each of the model's attributes.

- Our `user` model validates the presence of a secure password and the existence of an email in the `valid_emails` database.

- Our `valid_emails` model vaidates the presence and correct formatting of the email.

# To-Dos
Here is a suggested list of possible next steps for the project, in rough order of importance. Feel free to do something else based on your discussions with Sarah.

* Set default strings for the axes titles in visualizations. Talk to Sarah about what those default labels should be. (See the `chart_default_title` method in `app/models/visualization.rb`.)

* Write a concise description of what value is being computed on the chart itself (percentage relative to the group variable). Talk to Sarah about how to word this message. This will likely involve writing a prose sentence in `app/views/visualizations/_chart.html.erb`.

* Update the methods in `app/helpers/visualizations_helper.rb` to make use of Group Variable and Outcome Variable variable `role`s. 
- In particular, group data tables first by Group Variable and then by Outcome Variable. 
- Enforce the fact that visualizations must have exactly two variables, exactly one Group Variable and exactly one Outcome Variable.
- Change the code to compute percentages relative to the Group Variable instead of percentages based on the first variable stored in the `variables` array attribute of the `Visualization` object.

* Identify and fix remaining accessibility issues. The WAVE tool is helpful here. Especially, some HTML elements are missing labels, which screen readers need.

* Implement filters that support arbitrary subset-ing or delete filter code altogether. What we mean is that if there are several categories to a variable (e.g. CS, Math, History, English, and Political Science are categories within the First Major variable) we want a filter which will include an arbitrary subset of those categories (e.g. CS, History, and Political Science) to include into the chart, leaving the rest of the categories out. The current filter code does not even try to do this, but we didn’t have time to delete that code.

* Introduce checkboxes in the form for creating or updating visualizations so that users can use the filter feature described above.

* Either completely drop support for line and pie charts or implement a way to create these charts that is consistent with the mission of the visualization tool. That is, consider: how can line and pie charts be used to describe the relationships between Group Variables and Outcome Variables?

* In the charts, round reported percentages to an appropriate number of significant digits.

* Change the views so that the options for editing a chart are on the same page as the chart itself. Consider how to support a user who wants to go between editing chart options and viewing the results quickly.

* Implement an administrator tier, with special permissions to add or remove users and add or remove valid emails.

* Add search functionality on the listing (index) of saved visualizations.


## Notes & Considerations
* As mentioned above, the code still houses an outdated filtering system which is not accessible to users. We did not have enough time to remove these parts of the code. In the code, if you run into anything that has to do with filters, it is probably unused by the current website.

* In `app/helpers/visualizations_helper.rb`, the `get_chart_info` method takes the first variable of the visualization (Line 129). A better coding practice would be to directly obtain the “Group By” variable, in case of any changes to the structure of the visualization form. (Again, this is a To-Do list item above.)

* When a user enters axes titles, it isn’t immediately clear how they will show up on the ensuing bar or column chart. It’s a little unintuitive how the x-axis of a bar chart is essentially the same as the y-axis of a column chart, and the user is expected to enter these labels without knowing how the result will end up.

* The site should use official Grinnell colors, found in `app/assets/stylesheets/grin_colors.scss`.

# Tools & Learning Resources
- Ruby on Rails [Tutorial](https://www.learnenough.com/ruby-on-rails-6th-edition-tutorial) by Michael Hartl 
- Rails [Guides](https://guides.rubyonrails.org/)
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

A lot of this material is directly from the Ruby on Rails Tutorial by Hartl. We use many of his instructions and commands when explaining how to set up the project.
