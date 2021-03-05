class JobSeeker < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :applied_job_seekers, dependent: :destroy
  has_many :jobs, through: :applied_job_seekers
  has_one_attached :profile_picture

  validates :social_name, :cpf, :phone, :cv, presence: true
  validates :cpf, :phone, :cv, uniqueness: true

  def apply_to!(job)
    AppliedJobSeeker.create!(job_seeker: self, job: job)
  end

  def applied_to?(job)
    if AppliedJobSeeker.any?
      if (AppliedJobSeeker.pluck(:job_seeker_id).include? id) && 
         (AppliedJobSeeker.pluck(:job_id).include? job.id)

        AppliedJobSeeker.all.each do |ajs|
          return true if (ajs.job_seeker == self) && (ajs.job == job)
        end
        false
      else
        false
      end
    else
      false
    end
  end

  def unapply_to!(job)
    AppliedJobSeeker.all.each do |ajs|
      ajs.destroy if (ajs.job_seeker == self) && (ajs.job == job)
    end
  end

  def self.all_applied_job_seekers(company)
    applied_job_seekers = []
    all.each do |job_seeker|
      job_seeker.jobs.each do |job|
        if (job.company == company) && 
           (not applied_job_seekers.include? job_seeker)
          applied_job_seekers << job_seeker
        end
      end
    end
    applied_job_seekers
  end
end