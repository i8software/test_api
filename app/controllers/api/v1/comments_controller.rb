class Api::V1::CommentsController < ApplicationController
  def show
    @comment = Comment.find(params[:id])
    render json: @comment
  end

  def create
    @geo_cache = GeoCache.find(params[:geo_cache_id])
    @comment = @geo_cache.comments.build(resource_params)
    if @comment.save
      render json: @comment, serializer: CommentSerializer
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(resource_params)
      render json: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy!
    head :ok
  end

  private

  def resource_params
    rp = params.require(:comment).permit(:id, :comment)
    rp[:commenter_id] = current_resource_owner.id
    rp
  end
end
