class CreateCompanySocialWebs < ActiveRecord::Migration[6.1]
  def change
    create_table :company_social_webs do |t|
      t.references :company, null: false, foreign_key: true
      t.string :address_web

      t.timestamps
    end
  end
end
