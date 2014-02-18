class Animal < ActiveRecord::Base
  STATUS_TYPES = [ "Available", "Fostered" ]
  has_many :line_items
  
  before_destroy :ensure_not_referenced_by_any_line_item

  validates :name, :breed, :gender, :age, :habits, :image_url, presence: true
  validates :name, uniqueness: true
  validates :image_url, allow_blank: true, format: {
    with: %r{\.(gif|jpg|png)\Z}i,
    message: 'must be a URL for GIF, JPG or PNG image.'
  }
  
  def self.latest
    Animal.order(:updated_at).last
  end
  
  private
    # ensure that there are no pet selectors referencing this animal
    def ensure_not_referenced_by_any_pet_selector
      if pet_selectors.empty?
        return true
      else
        errors.add(:base, 'Pet Selectors present')
        return false
      end
    end
    
    # ensure that there are no line items referencing this animal
    def ensure_not_referenced_by_any_line_item
      if line_items.empty?
        return true
      else
        errors.add(:base, 'Line Items present')
        return false
      end
    end
end
