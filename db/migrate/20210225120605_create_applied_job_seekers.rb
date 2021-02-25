class CreateAppliedJobSeekers < ActiveRecord::Migration[6.1]
  def change
    create_table :applied_job_seekers do |t|
      t.references :job_seeker, null: false, foreign_key: true
      t.references :job, null: false, foreign_key: true

      t.timestamps
    end
  end
end
