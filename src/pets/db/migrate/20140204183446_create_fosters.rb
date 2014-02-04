class CreateFosters < ActiveRecord::Migration
  def change
    create_table :fosters do |t|

      t.timestamps
    end
  end
end
