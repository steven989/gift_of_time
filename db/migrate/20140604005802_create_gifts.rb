class CreateGifts < ActiveRecord::Migration
  def change
    create_table :gifts do |t|
        t.string :gift_name
        t.integer :user_id
        t.string :message
      t.timestamps
    end
  end
end
