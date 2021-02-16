class CreateCompanies < ActiveRecord::Migration[6.1]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :cnpj
      t.string :site
      t.text :company_history

      t.timestamps
    end
    add_index :companies, :name, unique: true
    add_index :companies, :cnpj, unique: true
    add_index :companies, :site, unique: true
    add_index :companies, :company_history, unique: true
  end
end
