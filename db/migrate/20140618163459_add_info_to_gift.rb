class AddInfoToGift < ActiveRecord::Migration
  def change
    add_column :gifts, :recipient_name, :string
    add_column :gifts, :relationship_to_gifter, :string
    add_column :gifts, :description, :text
    add_column :gifts, :cause, :string
    add_column :gifts, :other_cause, :string
    add_column :gifts, :inspiration, :text
    add_column :gifts, :feel, :text
    add_column :gifts, :detailed_message, :text
    remove_column :gifts, :message, :text
  end
end
