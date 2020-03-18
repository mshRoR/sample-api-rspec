class CommentsController < ApplicationController
  before_action :set_article
  before_action :set_comment, only: [:update, :destroy]

  # POST   /articles/:article_id/comments
  def create
    comment = @article.comments.create!(comment_params)

    render json: comment, status: :created
  end

  # PATCH/PUT    /articles/:article_id/comments/:id
  def update
    @comment.update(comment_params)

    head :no_content
  end

  # DELETE /articles/:article_id/comments/:id
  def destroy
    @comment.destroy

    head :no_content
  end

  private

  def comment_params
    params.require(:comment).permit(:article_id, :body)
  end

  def set_article
    @article = Article.find(params[:article_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end
end
