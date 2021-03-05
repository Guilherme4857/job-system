class CreateCompanyAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :company_addresses do |t|
      t.references :company, null: false, foreign_key: true
      t.string :public_place
      t.string :district
      t.string :city
      t.string :zip_code

      t.timestamps
    end


  end
end
