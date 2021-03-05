class AddStatusToEmployee < ActiveRecord::Migration[6.1]
  def change
    add_column :employees, :status, :integer, default: 0
  end
end
