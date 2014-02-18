class CreateConsiderations < ActiveRecord::Migration
  def change
    create_table :considerations do |t|

      t.timestamps
    end
  end
end
