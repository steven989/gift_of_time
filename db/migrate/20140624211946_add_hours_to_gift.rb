class AddHoursToGift < ActiveRecord::Migration
  def change
    add_column :gifts, :hours, :integer
  end
end
