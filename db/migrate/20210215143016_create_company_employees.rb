class CreateCompanyEmployees < ActiveRecord::Migration[6.1]
  def change
    create_table :company_employees do |t|
      t.references :company, null: false, foreign_key: true
      t.references :employee, null: false, foreign_key: true
      t.string :hostname

      t.timestamps
    end
  end
end
