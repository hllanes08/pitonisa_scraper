class API::V1::SearchesController < ApplicationController
    before_action :authenticate_with_token!, only: [:index]

    def index

	    searches = []
	    Search.where(user_id:current_user.id).group_by(&:tag).each do |tag, records|
		    searches.push( tag: tag, value: records.count )
    	    end
        render json: searches
    end
end
