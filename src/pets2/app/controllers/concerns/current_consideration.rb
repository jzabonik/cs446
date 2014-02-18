module CurrentConsideration
	extend ActiveSupport::Concern
	
	private
	
	def set_consideration
		@consideration = Consideration.find(session[:consideration_id])
	rescue ActiveRecord::RecordNotFound
		@consideration = Consideration.create
		session[:consideration_id] = @consideration.id
	end
end