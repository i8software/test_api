class Api::V1::ReactionsController < ApplicationController
  def index
    @reactions = resource_parent.reacted_on.search(params[:search])
                                .result(distinct: true)
                                .order(created_at: :desc)
                                .paginate(page: params[:page], per_page: params[:per_page])
    render json: @reactions, each_serializer: ReactionSerializer
  end

  def like
    response = reaction.like? ? destroy(reaction) : update(reaction, 1)
    if response == true
      head :ok
    else
      render json: response, status: :unprocessable_entity
    end
  end

  def unlike
    response = reaction.unlike? ? destroy(reaction) : update(reaction, -1)
    if response == true
      head :ok
    else
      render json: response, status: :unprocessable_entity
    end
  end

  private

  def resource_parent
    return GeoCache.find(params[:geo_cache_id]) if params[:geo_cache_id]
    return Comment.find(params[:comment_id]) if params[:comment_id]

    Reply.find(params[:reply_id])
  end

  def reaction
    user = current_resource_owner
    Reaction.find_by(reacted_on: resource_parent, reactor: user) || Reaction.new(reacted_on: resource_parent, reactor: user)
  end

  def destroy(reaction)
    if reaction.destroy
      true
    else
      reaction.errors
    end
  end

  def update(reaction, value)
    reaction.reaction = value
    if reaction.save
      true
    else
      reaction.errors
    end
  end
end
