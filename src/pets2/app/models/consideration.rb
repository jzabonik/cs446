class Consideration < ActiveRecord::Base
  has_many :line_items, dependent: :destroy
  
  def add_animal(animal_id)
    current_item = line_items.find_by(animal_id: animal_id)
    if current_item == nil
      current_item = line_items.build(animal_id: animal_id)
    end
    current_item
  end
end
