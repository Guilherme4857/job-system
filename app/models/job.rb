class Job < ApplicationRecord
  has_many :job_levels, dependent: :destroy
  has_many :levels, through: :job_levels, dependent: :destroy
  has_many :applied_job_seekers, dependent: :destroy
  has_many :job_seekers, through: :applied_job_seekers
  has_one :job_disable, dependent: :destroy
  belongs_to :company

  validates :title, :description, :pay_scale, :requirements, :expiration_date,
            :job_openings, :levels, presence: true
  validates_associated :levels

  def job_attributes(index)
    attributes = [Job.human_attribute_name('title'), Job.human_attribute_name('description'),
    Job.human_attribute_name('pay_scale'), Job.human_attribute_name('requirements'),
    Job.human_attribute_name('expiration_date'), Job.human_attribute_name('job_openings')]

    attributes[index]
  end

  def disable!
    JobDisable.create!(job: self)
  end

  def enable!
    job_disable.destroy
  end

  def disabled?
    if JobDisable.any?
      if JobDisable.pluck(:job_id).include? id
        true
      else
        false
      end
    else
      false
    end
  end

  def self.all_enable
    enables = []
    Job.all.map do |job|
      if not job.disabled?
        if job.expiration_date < Time.now.to_date
           job.disable!
        else
          enables << job
        end        
      end
    end
    enables
  end
end
