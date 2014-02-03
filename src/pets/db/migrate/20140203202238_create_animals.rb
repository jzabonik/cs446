class CreateAnimals < ActiveRecord::Migration
  def change
    create_table :animals do |t|
      t.string :name
      t.string :breed
	  t.string :gender
      t.string :age
      t.text :habits
      t.string :image_url

      t.timestamps
    end
  end
end
