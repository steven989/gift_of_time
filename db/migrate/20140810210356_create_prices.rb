class CreatePrices < ActiveRecord::Migration
  def change
    create_table :prices do |t|
        t.string :item
        t.integer :price_in_cents

      t.timestamps
    end
  end
end
