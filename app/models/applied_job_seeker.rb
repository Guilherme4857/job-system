class AppliedJobSeeker < ApplicationRecord
  belongs_to :job_seeker
  belongs_to :job
end
