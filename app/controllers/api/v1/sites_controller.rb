class API::V1::SitesController < ApplicationController
    before_action :authenticate_with_token!, only: [:index, :create]
    def index
	render json: Site.all
    end
    
    def create
	site = Site.new(site_params)
	if site.save
	    render json: site, status: 201
	else
	    render json: {errors: site.errors }, status: 422
	end
    end

    def popularize
    	site = Site.find(params[:id])
	render json: site.popularize
    end
    private

    def site_params
	params.require(:site).permit(:name, :url, :site_type)
    end
end
