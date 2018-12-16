class Api::V1::RepliesController < ApplicationController
  def show
    @reply = Reply.find(params[:id])
    render json: @reply
  end

  def create
    @comment = Comment.find(params[:comment_id])
    @reply = @comment.replies.build(resource_params)
    if @reply.save
      render json: @reply, serializer: ReplySerializer
    else
      render json: @reply.errors, status: :unprocessable_entity
    end
  end

  def update
    @reply = Reply.find(params[:id])
    if @reply.update(resource_params)
      render json: @reply
    else
      render json: @reply.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @reply = Reply.find(params[:id])
    @reply.destroy!
    head :ok
  end

  private

  def resource_params
    rp = params.require(:reply).permit(:id, :reply)
    rp[:sender_id] = current_resource_owner.id
    rp
  end
end
