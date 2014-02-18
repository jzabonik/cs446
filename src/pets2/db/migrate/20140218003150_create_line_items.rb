class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.references :animal, index: true
      t.belongs_to :consideration, index: true

      t.timestamps
    end
  end
end
