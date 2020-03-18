class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :update, :destroy]
  
  # GET /articles
  def index
    @articles = Article.all

    render json: @articles, status: :ok
  end

  # GET /articles/:id
  def show
    render json: @article, status: :ok
  end

  # POST /articles
  def create
    @article = Article.create!(article_params)

    render json: @article, status: :created
  end

  # PUT /articles/:id
  def update
    if @article.update(article_params)
      head :no_content
    else
      render json: @article.errors.messages, status: :unprocessable_entity
    end
  end

  # DELETE /articles/:id
  def destroy
    @article.destroy

    head :no_content
  end

  private

  def article_params
    params.require(:article).permit(:title, :description)
  end

  def set_article
    @article = Article.find(params[:id])
  end
end
