class AddRandomIdToGifts < ActiveRecord::Migration
  def change
    add_column :gifts, :gift_comp_id, :string
  end
end
