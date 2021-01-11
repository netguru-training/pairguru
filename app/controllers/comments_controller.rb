class CommentsController < MoviesController

  before_action :set_movie

  def create
    @comment = @movie.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to movie_path(@movie), notice: "Comment has been added"
    else
      redirect_to movie_path(@movie), alert: "Comment has not been added"
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to movie_path(@movie), notice: "Comment has been deleted"
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_movie
    @movie = Movie.find(params[:movie_id])
  end
end
