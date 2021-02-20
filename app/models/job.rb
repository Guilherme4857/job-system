class Job < ApplicationRecord
  has_many :job_levels
  has_many :levels, through: :job_levels
  belongs_to :company

  validates :title, :description, :pay_scale, :requirements, :expiration_date,
            :job_openings, presence: true
  validates_associated :levels, presence: true

  def job_attributes(index)
    attributes = [Job.human_attribute_name('title'), Job.human_attribute_name('description'),
    Job.human_attribute_name('pay_scale'), Job.human_attribute_name('requirements'),
    Job.human_attribute_name('expiration_date'), Job.human_attribute_name('job_openings')]

    attributes[index]
  end
end
