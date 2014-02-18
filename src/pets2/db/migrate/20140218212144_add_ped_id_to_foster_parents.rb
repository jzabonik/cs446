class AddPedIdToFosterParents < ActiveRecord::Migration
  def change
    add_column :foster_parents, :pet_id, :string
  end
end
