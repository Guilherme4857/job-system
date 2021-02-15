class Job < ApplicationRecord
  enum status: {admin: 10, common: 0} 
  validates :title, :description, :pay_scale, :level, 
            :requirements, :expiration_date, :job_openings, presence: true

  def job_attributes(attribute = nil)
     
    return nil if(not attribute.is_a? Numeric) or (not attribute) or (attribute < 0)
    attributes_list = [Job.human_attribute_name("title"), Job.human_attribute_name("description"), 
                       Job.human_attribute_name("pay_scale"), Job.human_attribute_name("level"), 
                       Job.human_attribute_name("requirements"), Job.human_attribute_name("expiration_date"), 
                       Job.human_attribute_name("job_openings")]

    attributes_list[attribute]

  end
end
