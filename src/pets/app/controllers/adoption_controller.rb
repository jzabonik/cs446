class AdoptionController < ApplicationController
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
