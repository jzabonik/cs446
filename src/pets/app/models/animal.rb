class Animal < ActiveRecord::Base
	validates :name, :breed, :gender, :age, :habits, :image_url, presence: true
	validates :name, uniqueness: true
	validates :image_url, allow_blank: true, format: {
		with: %r{\.(gif|jpg|png)\Z}i,
		message: 'must be a URL for GIF, JPG or PNG image.'
	}
	
	def self.latest
		Animal.order(:updated_at).last
	end
end
