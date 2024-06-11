=begin

What is Rails?
Rails is a web application development framework written in the Ruby programming language. It is designed to make programming web applications easier by making assumptions about what every developer needs to get started.

Rails is opinionated software. It makes the assumption that there is a "best" way to do things, and it's designed to encourage that way - and in some cases to discourage alternatives. If you learn "The Rails Way" you'll probably discover a tremendous increase in productivity. If you persist in bringing old habits from other languages to your Rails development, and trying to use patterns you learned elsewhere, you may have a less happy experience.





The Rails philosophy includes two major guiding principles:
Don't Repeat Yourself (DRY): DRY is a principle of software development which states that "Every piece of knowledge must have a single, unambiguous, authoritative representation within a system". By not writing the same information over and over again, our code is more maintainable, more extensible, and less buggy.

Convention Over Configuration: Rails has opinions about the best way to do many things in a web application, and defaults to this set of conventions, rather than require that you specify minutiae through endless configuration files.





Rails comes with a number of scripts called generators that are designed to make your development life easier by creating everything that's necessary to start working on a particular task. One of these is the new application generator, which will provide you with the foundation of a fresh Rails application so that you don't have to write it yourself.





*** Notes from the old computer ***





When an action does not explicitly, manually, render a view (or otherwise trigger an HTTP response), Rails will automatically render a view that matches the name of the controller and action. Convention Over Configuration! Views are located in the app/views directory.





Command: bin/rails server - starts the web server.





Rails applications do not use "require" to load application code.

Application classes and modules are available everywhere, you do not need and should not load anything under app with require. This feature is called autoloading.

Only need "require" calls for two use cases:
1. To load files under the lib directory.
2. To load gem dependencies that have require: false in the Gemfile.





MVC is a design pattern that divides the responsibilities of an application to make it easier to reason about. Rails follows this design pattern by convention.

A model is a Ruby class that is used to represent data. Additionally, models can interact with the application's database through a feature of Rails called Active Record.
Model names are singular, because an instantiated model represents a single data record. To help remember this convention, think of how you would call the model's constructor: we want to write Article.new(...), not Articles.new(...).





Migrations are used to alter the structure of an application's database. In Rails applications, migrations are written in Ruby so that they can be database-agnostic.





The Rails feature "console" is an interactive coding environment just like irb, but it also automatically loads Rails and our application code.
It's important to note that when initializing objects in the "console" - objects do NOT get saved to the database at all. It's only available in the "console" at the moment. To save objects to the database, we must call "save". For example, the name of the object then "save" - "article.save".





"ActiveRecord::Relation" objects can be cseen as super-powered array.





From steps 1-6: When starting the server (bin/rails server)
1. The browser makes a request: GET http://localhost:3000.
2. Our Rails application receives this request.
3. The Rails router maps the root route to the index action of ArticlesController.
4. The index action uses the Article model to fetch all articles in the database.
5. Rails automatically renders the app/views/articles/index.html.erb view.
6. The ERB code in the view is evaluated to output HTML.
7. The server sends a response containing the HTML back to the browser.





Step 7:
7.2:
Whenever there is a combination of "routes", "controller actions", and "views" that work together to perform CRUD operations on an entity, that entity is called a "resource". For example, in our application, we would say an article is a "resource".

Rails provides a "routes" method named "resources" that maps all of the conventional routes for a collection of resources, such as "articles" in our application.

Command "bin/rails routes" allows to inspect what "routes" are being mapped:
$ bin/rails routes
      Prefix Verb   URI Pattern                  Controller#Action
        root GET    /                            articles#index
    articles GET    /articles(.:format)          articles#index
 new_article GET    /articles/new(.:format)      articles#new
     article GET    /articles/:id(.:format)      articles#show
             POST   /articles(.:format)          articles#create
edit_article GET    /articles/:id/edit(.:format) articles#edit
             PATCH  /articles/:id(.:format)      articles#update
             DELETE /articles/:id(.:format)      articles#destroy
The "resources" method also sets up URL and path helper methods that can be use to keep code from depending on a specific route configuration. The values in the "Prefix" column above plus a suffix of "_url" or "_path" form the names of these helpers. For example, the "article_path" helper returns "/articles/#{article.id}" when given an article. Can use it to tidy up our links in app/views/articles/index.html.erb.

Before:
<h1>Articles</h1>
<ul>
  <% @articles.each do |article| %>
    <li>
      <%# Linking each article's to its page %>
      <a href="/articles/<%= article.id %>"><%= article.title %></a>
    </li>
  <% end %>
</ul>

After:
<h1>Articles</h1>
<ul>
  <% @articles.each do |article| %>
    <li>
      <%# Linking each article's to its page %>
      <a href="<%= article_path(article) %>"><%= article.title %></a>
    </li>
  <% end %>
</ul>

However, we will take this one step further by using the "link_to" helper. The "link_to" helper renders a link with its first argument as the link's text and its second argument as the link's destination. If we pass a "model" object as the second argument, "link_to" will call the appropriate path helper to convert the object to a path. For example, if we pass an article, "link_to" will call "article_path". So "app/views/articles/index.html.erb" becomes:
<h1>Articles</h1>
<ul>
  <% @articles.each do |article| %>
    <li>
      <%= link_to article.title, article %>
    </li>
  <% end %>
</ul>





7.3:
Rails provides a feature called "validations" to help us deal with invalid user input. "Validations" are rules that are checked before a "mode" object is saved. If any of the checks fail, the save will be aborted, and appropriate error messages will be added to the "errors" attribute of the "model" object.





7.4:
Our "edit" form will look the same as our "new" form. Even the code will be the same, thanks to the Rails "form builder" and "resourceful routing". The "form builder" automatically configures the "form" to make the appropriate kind of request, based on whether the "model" object has been previously saved.

=end










=begin

*** NOTE: Questions and comments for Diogo ***



7.4.1:
Code in the "new.html.erb" file before this step:
<h1>New Article</h1>

<%# Using the "partial" from "app/views/articles/_form.html.erb" via "render" %>
<%= render "form", article: @article %>

<%= form_with model: @article do |form| %>
  <div>
    <%= form.label :title %><br>
    <%= form.text_field :title %>
    <% @article.errors.full_messages_for(:title).each do |message| %>
      <div><%= message %></div>
    <% end %>
  </div>

  <div>
    <%= form.label :body %><br>
    <%= form.text_area :body %><br>
    <% @article.errors.full_messages_for(:body).each do |message| %>
      <div><%= message %></div>
    <% end %>
  </div>

  <div>
    <%= form.submit %>
  </div>
<% end %>

Code in the "new.html.erb" file after this step:
<h1>New Article</h1>

# Using the "partial" from "app/views/articles/_form.html.erb" via "render"
<%= render "form", article: @article %>

=end
