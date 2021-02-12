class Job < ApplicationRecord
  validates :title, :description, :pay_scale, :level, 
            :requirements, :expiration_date, :job_openings, presence: true
end
