class AdoptionController < ApplicationController
  def index
	@animals = Animal.order(:name)
  end
end
