class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment = Comment.new(comment_params)

    if @comment.save!
      redirect_to movie_path(params[:movie_id]), success: I18n.t('comment.succesfully_created')
    end
  rescue ActiveRecord::RecordInvalid => e
    redirect_to movie_path(params[:movie_id]), alert: e.message
  end

  def edit
    @comment = Comment.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: I18n.t('comment.not_found')
  end

  def update
    @comment = Comment.find(params[:id])

    if @comment.update!(comment_params)
      redirect_to movie_path(params[:movie_id]), success: I18n.t('comment.succesfully_updated')
    end
  rescue ActiveRecord::RecordInvalid => e
    render 'edit', alert: e.message
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: I18n.t('comment.not_found')
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    redirect_to movie_path(params[:movie_id]), success: I18n.t('comment.was_deleted')
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: I18n.t('comment.not_found')
  end

  private

  def comment_params
    params.require(:comment).permit(:description, :user_id, :movie_id)
  end
end
