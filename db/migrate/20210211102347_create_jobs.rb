class CreateJobs < ActiveRecord::Migration[6.1]
  def change
    create_table :jobs do |t|
      t.string :title
      t.text :description
      t.string :pay_scale
      t.string :level
      t.string :requirements
      t.date :expiration_date
      t.integer :job_openings

      t.timestamps
    end
  end
end
