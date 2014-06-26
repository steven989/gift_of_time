class AddCertificatePrintFlag < ActiveRecord::Migration
  def change
    add_column :gifts, :certificate_printed_by_user, :string
  end
end
