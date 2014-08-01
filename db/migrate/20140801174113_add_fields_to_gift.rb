class AddFieldsToGift < ActiveRecord::Migration
  def change
    add_column :gifts, :expected_hours, :integer
    add_column :gifts, :expected_completion_date, :date
  end
end
