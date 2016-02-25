class CommentsController < ApplicationController
  before_action :set_commentable
  before_action :authenticate_user!

  def create
     @comment = @commentable.comments.build(comment_params)
     @comment.user_id = current_user.id
     if @comment.save
       redirect_to @commentable
     end
  end

  def destroy
    comment = @commentable.comments.find(params[:id])
    comment.destroy
    redirect_to @commentable
  end

  def upvote
    @comment = @commentable.comments.find(params[:id])
    @comment.upvote_by current_user
    redirect_to :back

  end

  def downvote
    @comment = @commentable.comments.find(params[:id])
    @comment.downvote_by current_user
    respond_to do |format|
      format.html {redirect_to :back}

    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def set_commentable
    if params[:ocio_id]
        @commentable = Ocio.find(params[:ocio_id])
    elsif params[:alojamiento_id]
        @commentable = Alojamiento.find(params[:alojamiento_id])
    elsif params[:transport_id]
        @commentable = Transport.find(params[:transport_id])
    end
  end

end
