=begin

Rails applications do not use "require" to load application code.
ArticlesController inherits from ApplicationController.
DO NOT DO THIS - require "application_controller"

Application classes and modules are available everywhere, you do not need and should not load anything under "app" with "require". This feature is called "autoloading".

Only need "require" calls for two use cases:
1. To load files under the lib directory.
2. To load gem dependencies that have require: false in the Gemfile.

Controller instance variables, "@article", can be accessed by the view.

=end
=begin

The "show" action calls Article.find with the ID captured by the route parameter. The returned article is stored in the "@article" instance variable, so it is accessible by the "view". By default, the "show" action will render "app/views/articles/show.html.erb".

=end
=begin

The "new" action instantiates a new article, but does NOT save it. This article will be used in the "view" when building the form. By default, the "new" action will render app/views/articles/new.html.erb, for our application.

The "create" action instantiates a new article with values for the title and body, and attempts to save it. If the article is saved successfully, the action "redirects" the browser to the article's page at "http://localhost:3000/articles/#{@article.id}". Else, the action redisplays the form by rendering "app/views/articles/new.html.erb" with status code "422 Unprocessable Entity". The title and body here are dummy values.

*** IMPORT *** - The "redirect_to" will cause the browser to make a new request, whereas "render" - renders the specified view for the current request. It is important to use "redirect_to" after mutating the database or application state. Otherwise, if the user refreshes the page, the browser will make the same request, and the mutation will be repeated.

=end
=begin
class ArticlesController < ApplicationController
  # An "index" action
  def index
    @articles = Article.all
  end

  # A "show" action
  def show
    @article = Article.find(params[:id])
  end

  # A "new" action
  def new
    @article = Article.new
  end

  # A "create" action
  def create
    @article = Article.new(title: "...", body: "...")

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end
end
=end










=begin

Making chances from the version above. In this version I handled the "C" (Create) in CRUD.

Submitted form data is put into the "params" Hash, alongside captured "route" parameters. Thus, the "create" action can access the submitted "title" via "params[:article][:title]" and the submitted "body" via "params[:article][:body]". We could pass these values individually to "Article.new", but that would be verbose and possibly error-prone. And it would become worse as we add more fields.

Instead, we will pass a "single" Hash that contains the values. However, we must still specify what values are allowed in that Hash. Otherwise, a malicious user could potentially submit extra form fields and overwrite private data. In fact, if we pass the unfiltered "params[:article]" Hash directly to "Article.new", Rails will raise a "ForbiddenAttributesError" to alert us about the problem. So we will use a feature of Rails called "Strong Parameters" to filter "params". Think of it as strong typing for params.

Let's add a "private" method to the bottom of "app/controllers/articles_controller.rb" named "article_params" that filters "params". And let's change "create" to use it.

=end
=begin
class ArticlesController < ApplicationController
  # An "index" action
  def index
    @articles = Article.all
  end

  # A "show" action
  def show
    @article = Article.find(params[:id])
  end

  # A "new" action
  def new
    @article = Article.new
  end

  # A "create" action
  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  # Private method
  private
    def article_params
      params.require(:article).permit(:title, :body)
    end
end
=end










=begin

Making chances from the version above. In this version I handled the "U" (Update) in CRUD.

Notice how the "edit" and "update" actions resemble the "new" and "create" actions.

The "edit" action fetches the article from the database, and stores it in "@article", instance variable, so that it can be used when building the "form". By default, the "edit" action will render "app/views/articles/edit.html.erb".

The "update" action (re-)fetches the article from the database, and attempts to update it with the submitted form data filtered by "article_params". If no "validations" fail and the update is successful, the action redirects the browser to the article's page. Else, the action redisplays the form — with error messages — by rendering "app/views/articles/edit.html.erb".

=end
=begin
class ArticlesController < ApplicationController
  # An "index" action
  def index
    @articles = Article.all
  end

  # A "show" action
  def show
    @article = Article.find(params[:id])
  end

  # A "new" action
  def new
    @article = Article.new
  end

  # A "create" action
  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  # An "edit" action
  def edit
    @article = Article.find(params[:id])
  end

  # An "update" action
  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # Private method
  private
    def article_params
      params.require(:article).permit(:title, :body)
    end
end
=end










=begin

Making chances from the version above. In this version I handled the "D" (Delete) in CRUD.

Deleting a "resource" is a simpler process than creating or updating. It only requires a "route" and a "controller action". And our "resourceful routing" (resources :articles) already provides the "route", which maps "DELETE /articles/:id" requests to the "destroy" action of ArticlesController.

The "destroy" action fetches the article from the database, and calls "destroy" on it. Then, it redirects the browser to the "root" path with status code "303 See Other".

We have chosen to "redirect" to the "root" path because that is our main access point for articles. But, in other circumstances, you might choose to redirect to, for example, "articles_path".

=end
class ArticlesController < ApplicationController
  # An "index" action
  def index
    @articles = Article.all
  end

  # A "show" action
  def show
    @article = Article.find(params[:id])
  end

  # A "new" action
  def new
    @article = Article.new
  end

  # A "create" action
  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  # An "edit" action
  def edit
    @article = Article.find(params[:id])
  end

  # An "update" action
  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # A "destroy" action
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to root_path, status: :see_other
  end

  # Private method
  private
    def article_params
      params.require(:article).permit(:title, :body)
    end
end
