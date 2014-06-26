class CreateVolunteers < ActiveRecord::Migration
  def change
    create_table :volunteers do |t|
        t.string :title
        t.string :description
        t.string :organization
        t.string :hours
        t.string :location
        t.string :email
        t.string :contact_name
      t.timestamps
    end
  end
end
