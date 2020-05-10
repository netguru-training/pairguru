class CommentsController < ApplicationController
  def create
    @movie = Movie.find(params[:movie_id])
    @comment = @movie.comments.new(comment_params) do |c|
      c.user = current_user
    end
    
    if @comment.save()
      redirect_back(fallback_location: root_path, notice: "Comment added")
    else
      redirect_back(fallback_location: root_path, alert: @comment.errors)
    end
  end
  
  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      redirect_back(fallback_location: root_path, notice: "Comment deleted")
    else
      redirect_back(fallback_location: root_path, alert: @comment.errors)
    end
  end
  
  private 
  def comment_params
    params.require(:comment).permit(:body)
  end
end
