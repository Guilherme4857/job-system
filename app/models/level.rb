class Level < ApplicationRecord
  has_many :job_levels
  has_many :jobs, through: :job_levels
end
