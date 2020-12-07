class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to Movie.find_by(id: @comment.movie_id)
    end
  end

  def commentators        
    # @commentators =  User.joins(:comments).where('comments.created_at >= ?', 7.days.ago).uniq.sort_by(&:last_week_comments).reverse

    @commentators = User.joins("LEFT JOIN comments ON (comments.user_id = users.id)").
                         select("users.*, count(comments.*) as com").group('users.id').
                         order("com DESC").to_sql
  end

  def destroy
    @comment = Comment.find(params[:id])
    movie = Movie.find_by(id: @comment.movie_id)
    @comment.destroy
    redirect_to movie
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :user_id, :movie_id)
  end
end
