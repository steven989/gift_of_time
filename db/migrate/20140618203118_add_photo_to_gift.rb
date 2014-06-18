class AddPhotoToGift < ActiveRecord::Migration
  def change
    add_column :gifts, :volunteer_photos, :string
  end
end
