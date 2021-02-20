class CreateJobLevels < ActiveRecord::Migration[6.1]
  def change
    create_table :job_levels do |t|
      t.references :job, null: false, foreign_key: true
      t.references :level, null: false, foreign_key: true

      t.timestamps
    end
  end
end
