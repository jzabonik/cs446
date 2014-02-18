class CreateFosterParents < ActiveRecord::Migration
  def change
    create_table :foster_parents do |t|
      t.string :name
      t.text :address
      t.string :email
      t.references :animal, index: true

      t.timestamps
    end
  end
end
