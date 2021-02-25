class CreateJobDisables < ActiveRecord::Migration[6.1]
  def change
    create_table :job_disables do |t|
      t.references :job, null: false, foreign_key: true

      t.timestamps
    end
  end
end
