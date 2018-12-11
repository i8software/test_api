class Api::V1::GeoCachesController < ApplicationController
  def index
		@geo_caches = GeoCache.search(params[:search]).result(distinct: true).order(created_at: :desc)
      		                .paginate(page: params[:page], per_page: params[:per_page])
		render json: @geo_caches, each_serializer: GeoCachesSerializer
	end

  def show
    @geo_cache = GeoCache.find(params[:id])
    render json: @geo_cache
  end

  def create
    @geo_cache = GeoCache.new(resource_params)
    if @geo_cache.save
      render json: @geo_cache, serializer: GeoCacheSerializer
    else
      render json: @geo_cache.errors, status: :unprocessable_entity
    end
  end

  def update
    @geo_cache = GeoCache.find(params[:id])
    if @geo_cache.update(resource_params)
      render json: @geo_cache
    else
      render json: @geo_cache.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @geo_cache = GeoCache.find(params[:id])
    @geo_cache.destroy!
    head :ok
  end

  private

  def resource_params
    rp = params.require(:geo_cache).permit(:id, :lat, :lng, :title, :message)
    rp[:cacher_id] = current_resource_owner.id
    rp
  end
end
