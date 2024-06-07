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



Inside "app/views/articles/index.html.erb":
The above code is a mixture of HTML and ERB. ERB is a templating system that evaluates Ruby code embedded in a document. Here, we can see two types of ERB tags: <% %> and <%= %>.

The <% %> tag means "evaluate the enclosed Ruby code." The <%= %> tag means "evaluate the enclosed Ruby code, and output the value it returns." Anything you could write in a regular Ruby program can go inside these ERB tags, though it's usually best to keep the contents of ERB tags short, for readability.

Since we don't want to output the value returned by @articles.each, we've enclosed that code in <% %>. But, since we do want to output the value returned by article.title (for each article), we've enclosed that code in <%=. %>



From steps 1-6: When starting the server (bin/rails server)
1. The browser makes a request: GET http://localhost:3000.
2. Our Rails application receives this request.
3. The Rails router maps the root route to the index action of ArticlesController.
4. The index action uses the Article model to fetch all articles in the database.
5. Rails automatically renders the app/views/articles/index.html.erb view.
6. The ERB code in the view is evaluated to output HTML.
7. The server sends a response containing the HTML back to the browser.



Step 7:



=end



=begin

6.3 - irb> Article.all
=> #<ActiveRecord::Relation [#<Article id: 1, title: "Hello Rails", body: "I am on Rails!", created_at: "2020-01-18 23:47:30", updated_at: "2020-01-18 23:47:30">]>

Once, I entered the command I did not see "#<ActiveRecord::Relation" on the output.





=end
