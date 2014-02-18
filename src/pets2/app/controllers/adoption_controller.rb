class AdoptionController < ApplicationController
  include CurrentConsideration
  before_action :set_consideration
  
  def index
	@sort = params[:sort]
	if @sort
		if @sort == 'breed'
			@animals = Animal.order(:breed)
		else
			@animals = Animal.order(:name)
		end
	else
		@animals = Animal.order(:name)
	end
  end
end
