class CommentsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @comment = Comment.new(comment_params)
    @comment.meme_id = params[:meme_id]
    @comment.username = current_user.username
    @comment.save
    redirect_to meme_path(@comment.meme_id)
  end

  def destroy
    @comment.destroy
    redirect_to memes_path
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:meme_id, :body, :hearts)
    end
end
