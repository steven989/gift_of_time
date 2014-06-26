class AddOrgToGift < ActiveRecord::Migration
  def change
    add_column :gifts, :organization, :string
  end
end
