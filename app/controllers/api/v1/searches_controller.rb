class API::V1::SearchesController < ApplicationController
    before_action :authenticate_with_token!, only: [:index]

    def index
  	search = Search.where(user_id:current_user.id)
        render json: Search.all	
    end
end
