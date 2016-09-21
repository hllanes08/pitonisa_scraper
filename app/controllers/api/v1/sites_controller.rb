class API::V1::SitesController < ApplicationController
    before_action :authenticate_with_token!, only: [:index]
    def index
	render json: Site.all
    end
end
